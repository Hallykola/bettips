import 'package:equatable/equatable.dart';

class Tip extends Equatable {
	final int? id;
	final String? date;
	final String? title;
	final String? message;
	final String? image;
	final String? category;
	final String? subcategory;
	final String? level;

	const Tip({
		this.id,
		this.date,
		this.title,
		this.message,
		this.image,
		this.category,
		this.subcategory,
		this.level,
	});

	@override
	String toString() {
		return 'Tip(id: $id, date: $date, title: $title, message: $message, image: $image, category: $category, subcategory: $subcategory, level: $level)';
	}

	factory Tip.fromJson(Map<String, dynamic> json) {
		return Tip(
			id: json['id'] as int,
			date: json['date'] as String,
			title: json['title'] as String,
			message: json['message'] as String,
			image: json['image'] as String,
			category: json['category'] as String,
			subcategory: json['subcategory'] as String,
			level: json['level'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'date': date,
			'title': title,
			'message': message,
			'image': image,
			'category': category,
			'subcategory': subcategory,
			'level': level,
		};
	}

	Tip copyWith({
		int? id,
		String? date,
		String? title,
		String? message,
		String? image,
		String? category,
		String? subcategory,
		String? level,
	}) {
		return Tip(
			id: id ?? this.id,
			date: date ?? this.date,
			title: title ?? this.title,
			message: message ?? this.message,
			image: image ?? this.image,
			category: category ?? this.category,
			subcategory: subcategory ?? this.subcategory,
			level: level ?? this.level,
		);
	}

	@override
	List<Object> get props {
		return [
			id as int,
			date as String,
			title as String,
			message as String,
			image as String,
			category as String,
			subcategory as String,
			level as String,
		];
	}
}
