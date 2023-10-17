Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7F430F4
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi6sz4EB"
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A542CB0
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:48:18 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c4f69456aeso8511178a34.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697579298; x=1698184098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jj/BDLyDGa85AqSpf8Df2TijHyh0pX3EpIXoVJmKNCk=;
        b=gi6sz4EBJXXHstijbjXRHHmb7O2Y+koWFcl1JueeGAJ+IKJJuu2e6vhH3+aUcEzCOV
         9LSNiE3kbr9yKQRaJMhLkGR6uduvwYxIRkdzkX+0K4X78ZWfzyoSlqv3if0NMaC0jmkR
         ds4CBlg6nIhzpR3W9ElYLEa2TuG3eC5SNyqgb6evYz29xNRzTuYWR3CYa39Z9K3aOYAz
         7FGL1XWdR+yvv8XYxXQZtuXd8HnswjuAqqOWg0OcMpcGczEk5CiYXhDsOPAMpxbd1B0y
         Vg5RUwZ3cTEYn8kiO0VNpdMtFdgWdTJlLCii2ubidlSgEl933GUg+nGNlzKRENFhJ43K
         oBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579298; x=1698184098;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj/BDLyDGa85AqSpf8Df2TijHyh0pX3EpIXoVJmKNCk=;
        b=XN1n9X05uGNZIjzrXuF4tzdJoKXCS0HTS/vZLbNSlDDvvPgeOClBbAmy1ECLsLy5s2
         6O41TOXSTedlQ+ADpeOxRGBo5QTq5XhLdV0ahBa29/mNtmKzO01kVmbmbOtuvwaKszp9
         7rl1slpdV54z8Rd7meXKjvo9Ow5JdrYTvPZfEqKjr/nTs/Ktn71kWPw6LuaPs7RpHzTM
         VIAP9upqM9kMsBv5Omxrfmo1dYArgdEX8Q6QUq45i4JZ2219nAAB00Bb4OGlS+nObmRW
         zfgyWD7lijSImffWHYHqLu5KZkZ4omcjXDNIF+UB9hJKji13ELfrGNIqIuPkgi42CCRH
         69IA==
X-Gm-Message-State: AOJu0YxuzTDBkYwSebxn85TFGUqHA2fguokh3+4gVRyCm2scJ7/zICCk
	6EQkqPyP+mi11Y7g41k97EOyEVLnFc589ZV97g==
X-Google-Smtp-Source: AGHT+IGifKHIeEs6hQ9nd30qPs+zzZSt7lXKQ4GxXFSqvyt0kQejSoL8ILihmhinXdJGVmfGsL1ifdheILn0dvO2Ow==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:625a:0:b0:6c4:c061:341c with SMTP
 id i26-20020a9d625a000000b006c4c061341cmr1115376otk.5.1697579298035; Tue, 17
 Oct 2023 14:48:18 -0700 (PDT)
Date: Tue, 17 Oct 2023 21:48:15 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB4BL2UC/6WOQQqDMBBFr1Ky7pQkUg1d9R7FRTGjDthEZkJUx
 Ls39Qpdfd5fvP93JciEoh6XXTFmEoqhgL1eVDe+w4BAvrCy2lZGmwYkcejmDTxTRhYImGAhxgl
 FgELCCWhe7Kr1mbZkB3XvnCsGi7pWRT0z9rSes6+28EiSIm/ni2x+7Z+D2YABxMZXaO/ON+45x DhMeOviR7XHcXwBRc67tPkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697579297; l=3821;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ZZ92JxohATICi1IhnExgHVpB9lc7D4o0lN8/nCXFWag=; b=DLkNhMPJ2kmoCBTHgNn3p10//NWOir3cf1evFANYbRyynZLyFff7F4SXVKNXaWrlubIajvY6T
 XwkImuUtXeZBi+ck/Ln30rZdSFDnbjSVPJ4WXc5pMrUpe/SK/r2pKtU
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v2-1-465e10dc817c@google.com>
Subject: [PATCH v2] wifi: ipw2x00: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`extra` is intended to be NUL-terminated which is evident by the manual
assignment of a NUL-byte as well as its immediate usage with strlen().

Moreover, many of these getters and setters are NUL-padding buffers with
memset():
2439  |	memset(&tx_power, 0, sizeof(tx_power));
9998  | memset(sys_config, 0, sizeof(struct ipw_sys_config));
10084 | memset(tfd, 0, sizeof(*tfd));
10261 | memset(&dummystats, 0, sizeof(dummystats));
... let's maintain this behavior and NUL-pad our destination buffer.

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

To be clear, there is no bug in the current implementation as
MAX_WX_STRING is much larger than the size of the string literals being
copied from. Also, strncpy() does NUL-pad the destination buffer and
using strscpy_pad() simply matches that behavior. All in all, there
should be no functional change but we are one step closer to eliminating
usage of strncpy().

Do note that we cannot use the more idiomatic strscpy invocation of
(dest, src, sizeof(dest)) as the destination buffer cannot have its size
determined at compile time. So, let's stick with (dest, src, LEN).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- add wifi: to subject
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v1-1-ee7d3e258d78@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 820100cac491..44f2d91ad30f 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -9656,31 +9656,30 @@ static int ipw_wx_get_wireless_mode(struct net_device *dev,
 	mutex_lock(&priv->mutex);
 	switch (priv->ieee->mode) {
 	case IEEE_A:
-		strncpy(extra, "802.11a (1)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11a (1)", MAX_WX_STRING);
 		break;
 	case IEEE_B:
-		strncpy(extra, "802.11b (2)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11b (2)", MAX_WX_STRING);
 		break;
 	case IEEE_A | IEEE_B:
-		strncpy(extra, "802.11ab (3)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11ab (3)", MAX_WX_STRING);
 		break;
 	case IEEE_G:
-		strncpy(extra, "802.11g (4)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11g (4)", MAX_WX_STRING);
 		break;
 	case IEEE_A | IEEE_G:
-		strncpy(extra, "802.11ag (5)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11ag (5)", MAX_WX_STRING);
 		break;
 	case IEEE_B | IEEE_G:
-		strncpy(extra, "802.11bg (6)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11bg (6)", MAX_WX_STRING);
 		break;
 	case IEEE_A | IEEE_B | IEEE_G:
-		strncpy(extra, "802.11abg (7)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11abg (7)", MAX_WX_STRING);
 		break;
 	default:
-		strncpy(extra, "unknown", MAX_WX_STRING);
+		strscpy_pad(extra, "unknown", MAX_WX_STRING);
 		break;
 	}
-	extra[MAX_WX_STRING - 1] = '\0';
 
 	IPW_DEBUG_WX("PRIV GET MODE: %s\n", extra);
 

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-6f8880232e06

Best regards,
--
Justin Stitt <justinstitt@google.com>

