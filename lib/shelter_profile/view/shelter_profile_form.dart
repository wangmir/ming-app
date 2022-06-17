import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ming/shelter_profile/mock/mock.dart';
import 'package:ming/shelter_profile/model/shelter_profile.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/ui/thumbnail.dart';
import '../../generated/l10n.dart';
import '../../home/mock/mock.dart';

class ShelterProfileForm extends StatelessWidget {
  final ShelterProfile shelter;
  const ShelterProfileForm(this.shelter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ShelterPhotoSummary(shelterPhotosMock),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShelterDescription(shelter),
                        const ShelterCalender(),
                        ShelterLocation(shelter.manager, shelter.region),
                      ],
                    ),
                    flex: 2,
                  ),
                  const Expanded(
                    child: VolunteerReservationCard(true),
                    flex: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShelterCalender extends StatelessWidget {
  const ShelterCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            strings.volunteerSchedule,
            style: theme.textTheme.titleMedium,
          ),
        ),
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 90)),
          // todo: make this data change usable
          onDateChanged: (_) {},
        ),
        const Divider(),
      ],
    );
  }
}

class ShelterLocation extends StatelessWidget {
  final ShelterManagerProfile manager;
  final String address;
  const ShelterLocation(this.manager, this.address, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            strings.location,
            style: theme.textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (manager.imageUrl != null)
                ThumbnailImage(Image.network(manager.imageUrl!)),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.shelterOwner,
                    style: theme.textTheme.caption,
                  ),
                  Text(manager.name),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => launchUrlString("tel:${manager.phoneNumber}"),
                child: Text(strings.doCall),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 300,
          child: Card(
            child: Center(child: Text("map 위치")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(address),
        ),
        const Divider(),
      ],
    );
  }
}

class ShelterDescription extends StatelessWidget {
  final ShelterProfile shelter;
  const ShelterDescription(this.shelter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shelter.name,
          style: theme.textTheme.titleMedium,
        ),
        Row(
          children: [
            Text(
              strings.anbandonedDogString +
                  " ${shelter.numberOfDogs}" +
                  strings.unitStringOfPet +
                  " · " +
                  strings.abandonedCatString +
                  " ${shelter.numberOfCats}" +
                  strings.unitStringOfPet,
              style: theme.textTheme.caption,
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                size: 15,
              ),
              label: Text(
                strings.share,
              ),
            ),
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "⭐ ${shelter.averageRate} · " +
                strings.review +
                "${shelter.reviewCount}" +
                strings.unitStringOfShelter +
                " · " +
                shelter.region,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Row(
                children: userThumbnails
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          child: ThumbnailImage(e),
                        ))
                    .toList(),
              ),
              Text(
                "${shelter.numberOfVolunteers}" +
                    strings.volunteerNumberSentenceString,
              ),
            ],
          ),
        ),
        const Divider(),
        ExpandableNotifier(
          child: Expandable(
            collapsed: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    shelter.desc,
                    maxLines: 3,
                    softWrap: true,
                    // check https://github.com/flutter/flutter/issues/58626
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ExpandableButton(
                  child: Text(strings.showMore),
                ),
              ],
            ),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    shelter.desc,
                  ),
                ),
                ExpandableButton(
                  child: Text(strings.showLess),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
      ],
    );
  }
}

class VolunteerReservationCard extends StatelessWidget {
  final bool disabled;
  const VolunteerReservationCard(this.disabled, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                S.of(context).reserveVolunteer,
                style: theme.textTheme.titleMedium,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: strings.date),
              style: theme.textTheme.bodyText2,
              readOnly: true,
              initialValue: "6월 19일 2022년",
            ),
            TextFormField(
              decoration: InputDecoration(labelText: strings.time),
              style: theme.textTheme.bodyText2,
              readOnly: true,
              initialValue: "12:00",
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: strings.numberOfVolunteers),
              style: theme.textTheme.bodyText2,
              readOnly: true,
              initialValue: "1명",
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Center(child: Text("예약하기")),
            ),
          ],
        ),
      ),
    );
  }
}

class ShelterPhotoSummary extends StatelessWidget {
  final List<String> photos;

  const ShelterPhotoSummary(this.photos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 230,
        child: Stack(
          children: [
            Positioned.fill(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: photos
                    .map(
                      (e) => Image.network(e),
                    )
                    .toList(),
              ),
            ),
            Positioned(
              right: 25,
              bottom: 25,
              child: Card(
                child: Row(
                  children: [
                    const Icon(Icons.menu),
                    Text(S.of(context).showAllPhotos),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
