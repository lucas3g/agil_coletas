import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:flutter/material.dart';

class TiketController {
  static Color retornaCorDoCard(Tiket tiket) {
    if (tiket.alizarol) {
      return Colors.orange;
    }

    if (tiket.quantidade.value > 0 && tiket.temperatura.value != 0.0) {
      return Colors.green.shade400;
    }

    if (tiket.quantidade.value == 0 &&
        tiket.temperatura.value == 0.0 &&
        tiket.observacao.isEmpty) {
      return Colors.grey.shade400;
    }

    if (tiket.observacao.isNotEmpty) {
      return Colors.red.shade400;
    }

    return Colors.amber.shade300;
  }

  static Icon retornaIconeCard(Tiket tiket) {
    if (tiket.alizarol) {
      return const Icon(
        Icons.warning_amber_rounded,
        size: 30,
        color: Colors.black,
      );
    }

    if (tiket.quantidade.value > 0 && tiket.temperatura.value != 0.0) {
      return const Icon(
        Icons.check_circle_outline,
        size: 30,
        color: Colors.black,
      );
    }

    if (tiket.quantidade.value == 0 &&
        tiket.temperatura.value == 0.0 &&
        tiket.observacao.isEmpty) {
      return const Icon(
        Icons.person_outline,
        size: 30,
        color: Colors.black,
      );
    }

    if (tiket.observacao.isNotEmpty) {
      return const Icon(
        Icons.error_outline_rounded,
        size: 30,
        color: Colors.black,
      );
    }

    return const Icon(
      Icons.warning_amber_rounded,
      size: 30,
      color: Colors.black,
    );
  }

  static int totalColetado(List<Tiket> tickets) {
    final result = tickets.fold(
        0, (previousValue, e) => previousValue + e.quantidade.value);

    return result;
  }

  static atualizaColeta(
      List<Tiket> tickets, Coletas coleta, HomeBloc homeBloc) {
    final total = totalColetado(tickets);

    coleta.setTotalColetado(total);

    homeBloc.add(UpdateColetaEvent(coleta: coleta));
  }
}
