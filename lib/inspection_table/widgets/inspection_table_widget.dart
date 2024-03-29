import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InspectionTableWidget extends StatelessWidget {
  InspectionTableWidget({
    required this.homeInspections,
    super.key,
  });

  final List<HomeInspectionDetailed> homeInspections;
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    context.read<InspectionTableCubit>().setDataGridKey(_key);
    context.read<InspectionTableCubit>().changeKeyUpdated(isKeyUpdated: true);

    final l10n = context.l10n;
    final exportStatus =
        context.select<InspectionTableCubit, InspectionExportStatus>(
      (cubit) => cubit.state.exportStatus,
    );
    final inspectionCubit = context.read<InspectionTableCubit>();

    return ScaffoldPage(
      header: PageHeader(
        title: Text(l10n.inspectionTableAppBarTitle),
        commandBar: Expanded(
          child: CommandBarCard(
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.scrolling,
              primaryItems: [
                CommandBarButton(
                  icon: exportStatus == InspectionExportStatus.loading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: ProgressRing(
                            strokeWidth: 3,
                          ),
                        )
                      : const Icon(FluentIcons.excel_logo),
                  label: exportStatus == InspectionExportStatus.loading
                      ? Text(l10n.inspectionTableExportToExcelLoading)
                      : Text(l10n.inspectionTableExportToExcel),
                  onPressed: () => context
                      .read<InspectionTableCubit>()
                      .exportHomeInspectionsExcel(
                        dataGridKey: _key,
                        context: context,
                      ),
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.sync),
                  label: Text(l10n.inspectionTableUpdateText),
                  onPressed: () => inspectionCubit
                    ..getHomeInspections()
                    ..changeKeyUpdated(isKeyUpdated: true),
                ),
              ],
            ),
          ),
        ),
      ),
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Card(
                borderRadius: BorderRadius.circular(10),
                child: SfDataGrid(
                  key: _key,
                  source: InspectionTableDatagrid(
                    homeInspections: homeInspections,
                  ),
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  rowHeight: 40,
                  headerRowHeight: 50,
                  columns: _getColumns(context),
                  stackedHeaderRows: _getStackedHeaderRows(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GridColumn _getGridColumn(
    String columnName,
    String label,
    BuildContext context,
  ) {
    final longTitleColumns = <String>[
      'numberInhabitants',
      'inspectedHome',
      'reluctantDwelling',
      'closedHome',
      'uninhabitedHouse',
      'housingSpotlights',
      'treatedHousing',
      'inspectedContainers',
      'containersSpotlights',
      'treatedContainers',
      'destroyedContainers',
    ];
    final mediumTitleColumns = <String>[
      'larvae',
      'pupae',
      'adult',
      'larvicide',
    ];
    final shortTitleColumns = <String>[
      'elevatedTankI',
      'elevatedTankP',
      'elevatedTankT',
      'lowTankI',
      'lowTankP',
      'lowTankT',
      'cylinderBarrelI',
      'cylinderBarrelP',
      'cylinderBarrelT',
      'bucketTubI',
      'bucketTubP',
      'bucketTubT',
      'tireI',
      'tireP',
      'tireT',
      'flowerI',
      'flowerP',
      'flowerT',
      'uselessI',
      'uselessP',
      'uselessT',
      'othersI',
      'othersP',
      'othersT',
    ];

    var columnWidth = 0;

    if (longTitleColumns.contains(columnName)) {
      columnWidth = 110;
    } else if (mediumTitleColumns.contains(columnName)) {
      columnWidth = 90;
    } else if (shortTitleColumns.contains(columnName)) {
      columnWidth = 60;
    } else {
      columnWidth = 350;
    }

    return GridColumn(
      columnName: columnName,
      width: columnWidth.toDouble(),
      label: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: FluentTheme.of(context).typography.bodyStrong,
          maxLines: 2,
        ),
      ),
    );
  }

  List<GridColumn> _getColumns(BuildContext context) {
    final l10n = context.l10n;

    return [
      _getGridColumn('address', l10n.inspectionTableColumnAddress, context),
      _getGridColumn(
        'numberInhabitants',
        l10n.inspectionTableColumnNumberInhabitants,
        context,
      ),
      _getGridColumn(
        'inspectedHome',
        l10n.inspectionTableColumnInspectedHome,
        context,
      ),
      _getGridColumn(
        'reluctantDwelling',
        l10n.inspectionTableColumnReluctantDwelling,
        context,
      ),
      _getGridColumn(
        'closedHome',
        l10n.inspectionTableColumnClosedHome,
        context,
      ),
      _getGridColumn(
        'uninhabitedHouse',
        l10n.inspectionTableColumnUninhabitedHouse,
        context,
      ),
      _getGridColumn(
        'housingSpotlights',
        l10n.inspectionTableColumnHousingSpotlights,
        context,
      ),
      _getGridColumn(
        'treatedHousing',
        l10n.inspectionTableColumnTreatedHousing,
        context,
      ),
      _getGridColumn('elevatedTankI', 'I', context),
      _getGridColumn('elevatedTankP', 'P', context),
      _getGridColumn('elevatedTankT', 'T', context),
      _getGridColumn('lowTankI', 'I', context),
      _getGridColumn('lowTankP', 'P', context),
      _getGridColumn('lowTankT', 'T', context),
      _getGridColumn('cylinderBarrelI', 'I', context),
      _getGridColumn('cylinderBarrelP', 'P', context),
      _getGridColumn('cylinderBarrelT', 'T', context),
      _getGridColumn('bucketTubI', 'I', context),
      _getGridColumn('bucketTubP', 'P', context),
      _getGridColumn('bucketTubT', 'T', context),
      _getGridColumn('tireI', 'I', context),
      _getGridColumn('tireP', 'P', context),
      _getGridColumn('tireT', 'T', context),
      _getGridColumn('flowerI', 'I', context),
      _getGridColumn('flowerP', 'P', context),
      _getGridColumn('flowerT', 'T', context),
      _getGridColumn('uselessI', 'I', context),
      _getGridColumn('uselessP', 'P', context),
      _getGridColumn('uselessT', 'T', context),
      _getGridColumn('othersI', 'I', context),
      _getGridColumn('othersP', 'P', context),
      _getGridColumn('othersT', 'T', context),
      _getGridColumn(
        'inspectedContainers',
        l10n.inspectionTableColumnInspectedContainers,
        context,
      ),
      _getGridColumn(
        'containersSpotlights',
        l10n.inspectionTableColumnContainersSpotlights,
        context,
      ),
      _getGridColumn(
        'treatedContainers',
        l10n.inspectionTableColumnTreatedContainers,
        context,
      ),
      _getGridColumn(
        'destroyedContainers',
        l10n.inspectionTableColumnDestroyedContainers,
        context,
      ),
      _getGridColumn('larvae', l10n.inspectionTableColumnLarvae, context),
      _getGridColumn('pupae', l10n.inspectionTableColumnPupae, context),
      _getGridColumn('adult', l10n.inspectionTableColumnAdult, context),
      _getGridColumn('larvicide', l10n.inspectionTableColumnLarvicide, context),
    ];
  }

  Widget _getWidgetForStackedHeaderCell(
    String stackedColumnName,
    BuildContext context,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        stackedColumnName,
        textAlign: TextAlign.center,
        style: FluentTheme.of(context).typography.bodyStrong!.copyWith(
              fontSize: 16,
            ),
        maxLines: 2,
      ),
    );
  }

  List<StackedHeaderRow> _getStackedHeaderRows(BuildContext context) {
    final l10n = context.l10n;

    return [
      StackedHeaderRow(
        cells: [
          StackedHeaderCell(
            text: l10n.inspectionTableColumnTypeContainers,
            columnNames: [
              'elevatedTankI',
              'elevatedTankP',
              'elevatedTankT',
              'lowTankI',
              'lowTankP',
              'lowTankT',
              'cylinderBarrelI',
              'cylinderBarrelP',
              'cylinderBarrelT',
              'bucketTubI',
              'bucketTubP',
              'bucketTubT',
              'tireI',
              'tireP',
              'tireT',
              'flowerI',
              'flowerP',
              'flowerT',
              'uselessI',
              'uselessP',
              'uselessT',
              'othersI',
              'othersP',
              'othersT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnTypeContainers,
              context,
            ),
          ),
        ],
      ),
      StackedHeaderRow(
        cells: [
          StackedHeaderCell(
            text: l10n.inspectionTableColumnHomeCondition,
            columnNames: [
              'inspectedHome',
              'reluctantDwelling',
              'closedHome',
              'uninhabitedHouse',
              'housingSpotlights',
              'treatedHousing',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnHomeCondition,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnElevatedTank,
            columnNames: [
              'elevatedTankI',
              'elevatedTankP',
              'elevatedTankT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnElevatedTank,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnLowTank,
            columnNames: [
              'lowTankI',
              'lowTankP',
              'lowTankT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnLowTank,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnCylinderBarrel,
            columnNames: [
              'cylinderBarrelI',
              'cylinderBarrelP',
              'cylinderBarrelT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnCylinderBarrel,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnBucketTub,
            columnNames: [
              'bucketTubI',
              'bucketTubP',
              'bucketTubT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnBucketTub,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnTire,
            columnNames: [
              'tireI',
              'tireP',
              'tireT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnTire,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnFlower,
            columnNames: [
              'flowerI',
              'flowerP',
              'flowerT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnFlower,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnUseless,
            columnNames: [
              'uselessI',
              'uselessP',
              'uselessT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnUseless,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnOthers,
            columnNames: [
              'othersI',
              'othersP',
              'othersT',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnOthers,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnTotalContainer,
            columnNames: [
              'inspectedContainers',
              'containersSpotlights',
              'treatedContainers',
              'destroyedContainers',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnTotalContainer,
              context,
            ),
          ),
          StackedHeaderCell(
            text: l10n.inspectionTableColumnAegyptiFocus,
            columnNames: [
              'larvae',
              'pupae',
              'adult',
            ],
            child: _getWidgetForStackedHeaderCell(
              l10n.inspectionTableColumnAegyptiFocus,
              context,
            ),
          ),
        ],
      ),
    ];
  }
}

class InspectionTableDatagrid extends DataGridSource {
  InspectionTableDatagrid({
    required List<HomeInspectionDetailed> homeInspections,
  }) {
    _homeInspections = homeInspections
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell(
                columnName: 'address',
                value: e.address.formattedAddress,
              ),
              DataGridCell(
                columnName: 'numberInhabitants',
                value: e.numberInhabitants,
              ),
              DataGridCell(
                columnName: 'inspectedHome',
                value: e.homeCondition.inspectedHome,
              ),
              DataGridCell(
                columnName: 'reluctantDwelling',
                value: e.homeCondition.reluctantDwelling,
              ),
              DataGridCell(
                columnName: 'closedHome',
                value: e.homeCondition.closedHouse,
              ),
              DataGridCell(
                columnName: 'uninhabitedHouse',
                value: e.homeCondition.uninhabitedHouse,
              ),
              DataGridCell(
                columnName: 'housingSpotlights',
                value: e.homeCondition.housingSpotlights,
              ),
              DataGridCell(
                columnName: 'treatedHousing',
                value: e.homeCondition.treatedHousing,
              ),
              DataGridCell(
                columnName: 'elevatedTankI',
                value: e.typeContainer.elevatedTank.i,
              ),
              DataGridCell(
                columnName: 'elevatedTankP',
                value: e.typeContainer.elevatedTank.p,
              ),
              DataGridCell(
                columnName: 'elevatedTankT',
                value: e.typeContainer.elevatedTank.t,
              ),
              DataGridCell(
                columnName: 'lowTankI',
                value: e.typeContainer.lowTank.i,
              ),
              DataGridCell(
                columnName: 'lowTankP',
                value: e.typeContainer.lowTank.p,
              ),
              DataGridCell(
                columnName: 'lowTankT',
                value: e.typeContainer.lowTank.t,
              ),
              DataGridCell(
                columnName: 'cylinderBarrelI',
                value: e.typeContainer.cylinderBarrel.i,
              ),
              DataGridCell(
                columnName: 'cylinderBarrelP',
                value: e.typeContainer.cylinderBarrel.p,
              ),
              DataGridCell(
                columnName: 'cylinderBarrelT',
                value: e.typeContainer.cylinderBarrel.t,
              ),
              DataGridCell(
                columnName: 'bucketTubI',
                value: e.typeContainer.bucketTub.i,
              ),
              DataGridCell(
                columnName: 'bucketTubP',
                value: e.typeContainer.bucketTub.p,
              ),
              DataGridCell(
                columnName: 'bucketTubT',
                value: e.typeContainer.bucketTub.t,
              ),
              DataGridCell(
                columnName: 'tireI',
                value: e.typeContainer.tire.i,
              ),
              DataGridCell(
                columnName: 'tireP',
                value: e.typeContainer.tire.p,
              ),
              DataGridCell(
                columnName: 'tireT',
                value: e.typeContainer.tire.t,
              ),
              DataGridCell(
                columnName: 'flowerI',
                value: e.typeContainer.flower.i,
              ),
              DataGridCell(
                columnName: 'flowerP',
                value: e.typeContainer.flower.p,
              ),
              DataGridCell(
                columnName: 'flowerT',
                value: e.typeContainer.flower.t,
              ),
              DataGridCell(
                columnName: 'uselessI',
                value: e.typeContainer.useless.i,
              ),
              DataGridCell(
                columnName: 'uselessP',
                value: e.typeContainer.useless.p,
              ),
              DataGridCell(
                columnName: 'uselessT',
                value: e.typeContainer.useless.t,
              ),
              DataGridCell(
                columnName: 'othersI',
                value: e.typeContainer.others.i,
              ),
              DataGridCell(
                columnName: 'othersP',
                value: e.typeContainer.others.p,
              ),
              DataGridCell(
                columnName: 'othersT',
                value: e.typeContainer.others.t,
              ),
              DataGridCell(
                columnName: 'inspectedContainers',
                value: e.totalContainer.inspectedContainers,
              ),
              DataGridCell(
                columnName: 'containersSpotlights',
                value: e.totalContainer.containersSpotlights,
              ),
              DataGridCell(
                columnName: 'treatedContainers',
                value: e.totalContainer.treatedContainers,
              ),
              DataGridCell(
                columnName: 'destroyedContainers',
                value: e.totalContainer.destroyedContainers,
              ),
              DataGridCell(
                columnName: 'larvae',
                value: e.aegyptiFocus.larvae,
              ),
              DataGridCell(
                columnName: 'pupae',
                value: e.aegyptiFocus.pupae,
              ),
              DataGridCell(
                columnName: 'adult',
                value: e.aegyptiFocus.adult,
              ),
              DataGridCell(
                columnName: 'larvicide',
                value: e.larvicide,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _homeInspections = [];

  @override
  List<DataGridRow> get rows => _homeInspections;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          padding: const EdgeInsets.all(5),
          alignment: dataGridCell.columnName == 'address'
              ? Alignment.centerLeft
              : Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
