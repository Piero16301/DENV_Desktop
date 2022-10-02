import 'package:fluent_ui/fluent_ui.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InspectionTableWidget extends StatelessWidget {
  const InspectionTableWidget({
    super.key,
    required this.homeInspections,
  });

  final List<HomeInspectionDetailed> homeInspections;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: InspectionTableDatagrid(homeInspections: homeInspections),
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      rowHeight: 40,
      headerRowHeight: 50,
      columns: _getColumns(context),
      stackedHeaderRows: _getStackedHeaderRows(context),
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
      columnWidth = 120;
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
    return [
      _getGridColumn('address', 'Dirección', context),
      _getGridColumn('numberInhabitants', 'N° de habitantes', context),
      _getGridColumn('inspectedHome', 'Vivienda inspecionada', context),
      _getGridColumn('reluctantDwelling', 'Vivienda renuente', context),
      _getGridColumn('closedHome', 'Vivienda cerrada', context),
      _getGridColumn('uninhabitedHouse', 'Vivienda deshabitada', context),
      _getGridColumn('housingSpotlights', 'Vivienda focos', context),
      _getGridColumn('treatedHousing', 'Vivienda tratada con abte', context),
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
        'Recipientes inspeccionados',
        context,
      ),
      _getGridColumn('containersSpotlights', 'Recipientes focos', context),
      _getGridColumn('treatedContainers', 'Recipientes tratados', context),
      _getGridColumn('destroyedContainers', 'Recipientes destruidos', context),
      _getGridColumn('larvae', 'Larvas', context),
      _getGridColumn('pupae', 'Pupas', context),
      _getGridColumn('adult', 'Adulto', context),
      _getGridColumn('larvicide', 'Larvicida', context),
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
        style: FluentTheme.of(context).typography.bodyStrong,
        maxLines: 2,
      ),
    );
  }

  List<StackedHeaderRow> _getStackedHeaderRows(BuildContext context) {
    return [
      StackedHeaderRow(
        cells: [
          StackedHeaderCell(
            columnNames: [
              'inspectedHome',
              'reluctantDwelling',
              'closedHome',
              'uninhabitedHouse',
              'housingSpotlights',
              'treatedHousing',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Condición de viviendas',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'elevatedTankI',
              'elevatedTankP',
              'elevatedTankT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Tanque elevado',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'lowTankI',
              'lowTankP',
              'lowTankT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Tanque bajo, pozos',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'cylinderBarrelI',
              'cylinderBarrelP',
              'cylinderBarrelT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Barril, cilindro sanson',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'bucketTubI',
              'bucketTubP',
              'bucketTubT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Balde, abtea, tina',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'tireI',
              'tireP',
              'tireT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Llanta',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'flowerI',
              'flowerP',
              'flowerT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Florero, maceta',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'uselessI',
              'uselessP',
              'uselessT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Inservibles',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'othersI',
              'othersP',
              'othersT',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Otros',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'inspectedContainers',
              'containersSpotlights',
              'treatedContainers',
              'destroyedContainers',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Total de recipiente',
              context,
            ),
          ),
          StackedHeaderCell(
            columnNames: [
              'larvae',
              'pupae',
              'adult',
            ],
            child: _getWidgetForStackedHeaderCell(
              'Foco de A. Aegypti',
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
                value: e.homeCondition.closedHome,
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
                value: e.typeContainers.elevatedTank.i,
              ),
              DataGridCell(
                columnName: 'elevatedTankP',
                value: e.typeContainers.elevatedTank.p,
              ),
              DataGridCell(
                columnName: 'elevatedTankT',
                value: e.typeContainers.elevatedTank.t,
              ),
              DataGridCell(
                columnName: 'lowTankI',
                value: e.typeContainers.lowTank.i,
              ),
              DataGridCell(
                columnName: 'lowTankP',
                value: e.typeContainers.lowTank.p,
              ),
              DataGridCell(
                columnName: 'lowTankT',
                value: e.typeContainers.lowTank.t,
              ),
              DataGridCell(
                columnName: 'cylinderBarrelI',
                value: e.typeContainers.cylinderBarrel.i,
              ),
              DataGridCell(
                columnName: 'cylinderBarrelP',
                value: e.typeContainers.cylinderBarrel.p,
              ),
              DataGridCell(
                columnName: 'cylinderBarrelT',
                value: e.typeContainers.cylinderBarrel.t,
              ),
              DataGridCell(
                columnName: 'bucketTubI',
                value: e.typeContainers.bucketTub.i,
              ),
              DataGridCell(
                columnName: 'bucketTubP',
                value: e.typeContainers.bucketTub.p,
              ),
              DataGridCell(
                columnName: 'bucketTubT',
                value: e.typeContainers.bucketTub.t,
              ),
              DataGridCell(
                columnName: 'tireI',
                value: e.typeContainers.tire.i,
              ),
              DataGridCell(
                columnName: 'tireP',
                value: e.typeContainers.tire.p,
              ),
              DataGridCell(
                columnName: 'tireT',
                value: e.typeContainers.tire.t,
              ),
              DataGridCell(
                columnName: 'flowerI',
                value: e.typeContainers.flower.i,
              ),
              DataGridCell(
                columnName: 'flowerP',
                value: e.typeContainers.flower.p,
              ),
              DataGridCell(
                columnName: 'flowerT',
                value: e.typeContainers.flower.t,
              ),
              DataGridCell(
                columnName: 'uselessI',
                value: e.typeContainers.useless.i,
              ),
              DataGridCell(
                columnName: 'uselessP',
                value: e.typeContainers.useless.p,
              ),
              DataGridCell(
                columnName: 'uselessT',
                value: e.typeContainers.useless.t,
              ),
              DataGridCell(
                columnName: 'othersI',
                value: e.typeContainers.others.i,
              ),
              DataGridCell(
                columnName: 'othersP',
                value: e.typeContainers.others.p,
              ),
              DataGridCell(
                columnName: 'othersT',
                value: e.typeContainers.others.t,
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
