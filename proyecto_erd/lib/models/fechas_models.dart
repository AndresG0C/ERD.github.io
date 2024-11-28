class RegistroEstado {
  final DateTime f053Ts;
  final int f053IdCia;
  final DateTime f053Id;
  final int f053IndFestivo;
  final int f053IndEstadoCm;
  final int f053IndEstadoCo;
  final int f053IndEstadoCxc;
  final int f053IndEstadoCxp;
  final int f053IndEstadoAf;
  final int f053IndEstadoInv;
  final int f053IndEstadoVta;
  final int f053IndEstadoMan;
  final int f053IndEstadoVeh;
  final int f053IndEstadoPos;

  RegistroEstado({
    required this.f053Ts,
    required this.f053IdCia,
    required this.f053Id,
    required this.f053IndFestivo,
    required this.f053IndEstadoCm,
    required this.f053IndEstadoCo,
    required this.f053IndEstadoCxc,
    required this.f053IndEstadoCxp,
    required this.f053IndEstadoAf,
    required this.f053IndEstadoInv,
    required this.f053IndEstadoVta,
    required this.f053IndEstadoMan,
    required this.f053IndEstadoVeh,
    required this.f053IndEstadoPos,
  });

  // Método para convertir desde JSON
  factory RegistroEstado.fromJson(Map<String, dynamic> json) {
    return RegistroEstado(
      f053Ts: DateTime.parse(json['f053_ts']),
      f053IdCia: json['f053_id_cia'],
      f053Id: DateTime.parse(json['f053_id']),
      f053IndFestivo: json['f053_ind_festivo'],
      f053IndEstadoCm: json['f053_ind_estado_cm'],
      f053IndEstadoCo: json['f053_ind_estado_co'],
      f053IndEstadoCxc: json['f053_ind_estado_cxc'],
      f053IndEstadoCxp: json['f053_ind_estado_cxp'],
      f053IndEstadoAf: json['f053_ind_estado_af'],
      f053IndEstadoInv: json['f053_ind_estado_inv'],
      f053IndEstadoVta: json['f053_ind_estado_vta'],
      f053IndEstadoMan: json['f053_ind_estado_man'],
      f053IndEstadoVeh: json['f053_ind_estado_veh'],
      f053IndEstadoPos: json['f053_ind_estado_pos'],
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'f053_ts': f053Ts.toIso8601String(),
      'f053_id_cia': f053IdCia,
      'f053_id': f053Id.toIso8601String(),
      'f053_ind_festivo': f053IndFestivo,
      'f053_ind_estado_cm': f053IndEstadoCm,
      'f053_ind_estado_co': f053IndEstadoCo,
      'f053_ind_estado_cxc': f053IndEstadoCxc,
      'f053_ind_estado_cxp': f053IndEstadoCxp,
      'f053_ind_estado_af': f053IndEstadoAf,
      'f053_ind_estado_inv': f053IndEstadoInv,
      'f053_ind_estado_vta': f053IndEstadoVta,
      'f053_ind_estado_man': f053IndEstadoMan,
      'f053_ind_estado_veh': f053IndEstadoVeh,
      'f053_ind_estado_pos': f053IndEstadoPos,
    };
  }
}
