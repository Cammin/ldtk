package ui.modal.dialog;

class Sync extends ui.modal.Dialog {
	public function new(log:SyncLog, filePath:String, newProject:data.Project) {
		super();

		var fileName = dn.FilePath.fromFile(filePath).fileWithExt;
		loadTemplate("sync");
		jContent.find("h2 .file").text( fileName );

		// Add "DateUpdated" line
		log = log.copy();
		log.push({ op:DateUpdated, str:'File date of $fileName' });

		// Warning
		jContent.find(".warning").hide();
		for(l in log)
			switch l.op {
				case Add:
				case ChecksumUpdated:
				case DateUpdated:
				case Remove(used): if( used ) jContent.find(".warning").show();
			}

		// Hide safe notice
		if( jContent.find(".warning").is(":visible") )
			jContent.find(".safe").hide();

		// Log
		var jList = jContent.find(".log");
		for(l in log) {
			var li = new J('<li></li>');
			var label = l.str;
			switch l.op {
				case Add: li.append('<span class="op">New</op>');

				case Remove(used):
					li.append('<span class="op">Removed</op>');
					if( !used )
						li.addClass("unused");
					label += used ? L.t._(" (USED IN PROJECT!)") : L.t._(" (not used in this project)");

				case ChecksumUpdated:
					li.append('<span class="op">No change</op>');

				case DateUpdated:
					li.append('<span class="op">Updated</op>');
			}
			li.append(label);
			li.addClass("op"+l.op.getName());
			li.appendTo(jList);
		}

		// Buttons
		addButton(L.t._("Apply these changes"), "confirm", function() {
			new LastChance( Lang.t._("External file \"::name::\" synced", { name:fileName }), editor.project );
			editor.selectProject(newProject);
		});

		addCancel();
	}
}