Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32B381B4
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6b3TzD4"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B63EA
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 15:38:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7dac80595so74527607b3.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697495903; x=1698100703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfGwHPiYseuIB04WY1jIM0LXVs+wtH1jXMPtU9N43zs=;
        b=J6b3TzD4+gcfJcD2ESwDrx1CSo3G3phEwPdaz22RHEmPLa251ViTgB+XNQnlzCVKSI
         D0+eUSBFrryylKoc1xtnKobuVxOkQUQMANjgreWwLUybOtmt1kP3xwpjifkCvinUPjVc
         +XYNcbyTaKxyR28t5NjvkOza/Gq+ne1LsVlklCcQFKEh2suRHRbpZB/wEQa5aEZCj3fh
         FzorxcmotQSk/2Y1OUuB7QvyqUefqJx7Lq/IbQR+VYwXckczESmQEqMZgjo13NHpKNT1
         QwApOwVTcgmyhnlUGGdkPhqgHoBTpWeopU/Ftv9X555iiKlF47GKH7mr2ZLZBHjwI+ie
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697495903; x=1698100703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfGwHPiYseuIB04WY1jIM0LXVs+wtH1jXMPtU9N43zs=;
        b=camawKvTmkbG2jAXk71DbBGT7Ta0pSoDwnRrCRbS419/DnWplA11wX1mY4H6K06U58
         /8t+h9FlQJYNmj2y8Qi8E8jyQFUwc7QeuwCBDS5oxTtclK6+SmIpMuE+vXFnbZkgOpwq
         flhRo3szbQ6Zm7HAEDNVp6pWPuaxkqSzJlqtNjcMct0CTlj42kqp+NktZEmF7hRVIFnI
         3PPzwiYudZ70gQZd/6gg71//tlb/fdcN3IfhBaWoMsrsZo58Hro1R6txYiwNNTIt8OX9
         RoexDE0X9tivMBjOk4mHadhWWV1WH3ZRVPh/jE4fT0Tfovv0ugckQ2i3Jb2ywmbCpWY5
         3PSQ==
X-Gm-Message-State: AOJu0Ywtw5wb0hlcpcfdZTGn0XenCoBHEvW36huPsrM3oAhKhQzOE5C7
	SakR5jl47SL93iYTMCJrgjWDD8d2+YxFtfVlgQ==
X-Google-Smtp-Source: AGHT+IE7UKckRpGvTsEyas9ajW3OpcUNBDlz8M6iI1mSjq5sbYon/JJP4IFvS+a3lHmzLj+l3IZgZgtqQhvVSDAs7g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a214:0:b0:5a7:af9a:7530 with SMTP
 id w20-20020a81a214000000b005a7af9a7530mr13026ywg.1.1697495902914; Mon, 16
 Oct 2023 15:38:22 -0700 (PDT)
Date: Mon, 16 Oct 2023 22:38:20 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFu7LWUC/5WNTQqDMBSEryJZ95X8NFi78h5FSpq8xgfVSGJDR
 bx7ozfoYmC+WXyzsoSRMLFbtbKImRKFsYA8Vcz2ZvQI5AozyaXijbhAmuNopwVcpIwxgZ8+pQ9
 7HkNwmMCCUdrVV2mN44IV0xTxRd/j5d4V7inNIS7HaRb7+p8/CxDA6+apldRaGdX6EPwbzzYMr Nu27QepuXgo1wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697495902; l=2621;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=TJW5gbFFOQpXDfDl5XUoO1+aPZvb/beyqblsIzLDODQ=; b=Jr8r8/EvJkzNSU8MDRFRbOGBeDpanyMebo+SVS5CU/dprVV/kh/VtN1BGAtRJ27wIjeHTlzp1
 6/VI8g3xYjjDTFjHLJgbeHe+TZzGUb9EXm/g4j4Wiey/482jTTXVbq/
X-Mailer: b4 0.12.3
Message-ID: <20231016-strncpy-drivers-gpu-drm-drm_modes-c-v2-1-d0b60686e1c6@google.com>
Subject: [PATCH v2] drm/modes: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We should NUL-pad as there are full struct copies happening in places:
|       struct drm_mode_modeinfo umode;
|
|       ...
|               struct drm_property_blob *blob;
|
|               drm_mode_convert_to_umode(&umode, mode);
|               blob = drm_property_create_blob(crtc->dev,
|                                               sizeof(umode), &umode);

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees both NUL-termination and NUL-padding on the destination
buffer.

Additionally, replace size macro `DRM_DISPLAY_MODE_LEN` with sizeof() to
more directly tie the maximum buffer size to the destination buffer:
|       struct drm_display_mode {
|               ...
|       	char name[DRM_DISPLAY_MODE_LEN];

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad (thanks Kees)
- rebase onto mainline
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com
---
Note: build-tested only.
---
 drivers/gpu/drm/drm_modes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..893f52ee4926 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -2617,8 +2617,7 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 		break;
 	}
 
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy_pad(out->name, in->name, sizeof(out->name));
 }
 
 /**
@@ -2659,8 +2658,7 @@ int drm_mode_convert_umode(struct drm_device *dev,
 	 * useful for the kernel->userspace direction anyway.
 	 */
 	out->type = in->type & DRM_MODE_TYPE_ALL;
-	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
-	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
+	strscpy_pad(out->name, in->name, sizeof(out->name));
 
 	/* Clearing picture aspect ratio bits from out flags,
 	 * as the aspect-ratio information is not stored in

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20230914-strncpy-drivers-gpu-drm-drm_modes-c-a35d782cad01

Best regards,
--
Justin Stitt <justinstitt@google.com>

