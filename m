Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499B1859
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zsEk+K9L"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FD10C3
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 14:58:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d1816bccso51570237b3.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698098313; x=1698703113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lplfIxKbwXfc4j0px8yADDJAew/JRR45TLtG3ONcRNY=;
        b=zsEk+K9LK51vLhoScELCPAHscZxaV/QIVvVRl3uUREKyCWbWMxLfi7UEHFaq/TNqot
         kc2InySeSLAmxbzFfXoD4VaTXEHz3lxVQVWhXiRs0ZJENU1DosZURBGKrivvNrWMYfzf
         QjUFtbbpe4gx7x7H3TSKT8+slg91pTvi36yZ6w7MQkD2VFqk2uBbIZxCTDAWpTBb/dt3
         1lV/m5OLgvSqsnAz1v5W5i3BgjOCyG1AslO2NpP6VG7hXKdUFm3HqWCpKg2f1+WEAGBe
         sz9mIb/w9qstcklDlkbRKHINhwg5oczgf740n02rE6hVWXAbsB2lpngxoo5XQiIhVuvu
         lo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698098313; x=1698703113;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lplfIxKbwXfc4j0px8yADDJAew/JRR45TLtG3ONcRNY=;
        b=aQLMO/UVyIez5x/x77pB0Tq6CUe73TI8vYmEl1I8NgCck+ieH6ApfVN/gBL8ziO80L
         SCnl0sd3oKHDB0q58tcf61J0oT03HHxkyUmbCZMyDjv9V09njpSo4iAjhsbv94HZgB5H
         A5xggoIpx9PiR5UiuhWhWE7QcjeukwR93YZTbmaOgVYasUudrzxI+fZ/BlY0quLiAnnq
         g9aO/ePpH0R6Gc8EByNSVs/jK8TQHahvBMRqAR0S8cWmf6UtsqmpZZPL1/cQbhSVgrlM
         QQmPS24HLK5L+KSc75IygCHfylkvXaXmAVafcjP+KzZx/5OAq77kcQfmijA6Hr8Ewp10
         rxkQ==
X-Gm-Message-State: AOJu0Yw0OzFzfRqOEtnmOEWgOXdm/VRMIztJd/Fn4TdgnR12cpN+/D/O
	T9jCC7xru24RU+YCQRnpVhZAANXr/WmkodYxLg==
X-Google-Smtp-Source: AGHT+IH1VCJqGKWhTPwiG58AhWDntEk6e0Cr9Wama7S56Trg79QrVRiNWQssQZcjxWzt43q0MaRWKT+ffEii88qtBg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:dd02:0:b0:579:f832:74b with SMTP
 id g2-20020a0ddd02000000b00579f832074bmr247586ywe.10.1698098313044; Mon, 23
 Oct 2023 14:58:33 -0700 (PDT)
Date: Mon, 23 Oct 2023 21:58:32 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIfsNmUC/x2NQQqDQAwAvyI5N9BVZKlfkVK62awGZJWkiEX8e
 0MPc5jLzAnGKmwwNCco72KyVpdwa4Dmd50YJbtDe2+74KB9tNL2xayysxoamSAvBy6SuBA6r7p mxhkppRL7LjxiiuDBTbnI8Z+Nz+v6AXD8Le58AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698098312; l=2186;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=hqkcQUr/WEsQ9djykeodKpHEXayH5DyAwwnmmf9qdpA=; b=SagiCpSLtykvm17v/plCsQA3GNG2yh2JnJbu/1dbbizqlrX1TDrPn0NwucSKvOETDBvbBkuR8
 zoejEP8XQ5HATTtFw7HIQW0WisLKWtvKaqJs6GR2DhqV+cm7zv/GNb9
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-v1-1-8b66878b6796@google.com>
Subject: [PATCH] scsi: elx: libefc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: James Smart <james.smart@broadcom.com>, Ram Vegesna <ram.vegesna@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

There seems to not be any uses of `current_state_name` other than in
these assignments. Judging from context surrounding these assignments,
especially considering the string literal "invalid" being assigned, we
want both current_state_name and prev_state_name to be NUL-terminated
strings.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/elx/libefc/efc_node.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/elx/libefc/efc_node.h b/drivers/scsi/elx/libefc/efc_node.h
index e9c600ac45d5..3a16703d0f97 100644
--- a/drivers/scsi/elx/libefc/efc_node.h
+++ b/drivers/scsi/elx/libefc/efc_node.h
@@ -26,12 +26,12 @@ efc_node_evt_set(struct efc_sm_ctx *ctx, enum efc_sm_event evt,
 	struct efc_node *node = ctx->app;
 
 	if (evt == EFC_EVT_ENTER) {
-		strncpy(node->current_state_name, handler,
+		strscpy(node->current_state_name, handler,
 			sizeof(node->current_state_name));
 	} else if (evt == EFC_EVT_EXIT) {
-		strncpy(node->prev_state_name, node->current_state_name,
+		strscpy(node->prev_state_name, node->current_state_name,
 			sizeof(node->prev_state_name));
-		strncpy(node->current_state_name, "invalid",
+		strscpy(node->current_state_name, "invalid",
 			sizeof(node->current_state_name));
 	}
 	node->prev_evt = node->current_evt;

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-cbbf753197b7

Best regards,
--
Justin Stitt <justinstitt@google.com>

