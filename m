Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEBACA0EC3
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 02:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjILCAg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjILCAT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Sep 2023 22:00:19 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DA35251
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 15:09:13 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1b728bfb372so5904889fac.2
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694470046; x=1695074846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NK0s8SwuB91DWwghCh8BX+3yjh1iN5SeTvgDiCf+Aag=;
        b=2380YvAtxV6llHsr/hxkJniMqCPa7nZi2ZQ9BEVfSPqSAWCARy7utgkkMik8z4AVDQ
         TxebtovJJeveWJMXARHKup3L6UGxl8RLwGHhd72fxe+c6hr5+yJaVCbJAaq40TxaoHij
         zth4mG1ZM3gJhuVyYU0Bzo/HwE7SejOCp5IUgUSHbn8O/nQtXKGnZF6YIlf76pLfiZui
         857W9yUCL3DQtPYmoY0A4nQTKX2whsA3aGz2hkUYf5XXKb33H5tcttAq0DzXgITbDJK1
         5M6JR4YENhSYTCLeJGn/9VWvNiPEVSCW5J0wJqIMccQI8nUxN4l9mcIPPgzTOkp93j+P
         MkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694470046; x=1695074846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NK0s8SwuB91DWwghCh8BX+3yjh1iN5SeTvgDiCf+Aag=;
        b=VaDa35YtgMFRNY/9mdklG2YdVIWs6/RIP4zbfgAZxhIj7IFNWnU/Ow6igNrTwPY90g
         qqRLC5tVP7DHr/euEtd7aZU1JPcoA072aC8g7jB4qRsaVW1AuG4CnTM0Xwze6oTggxe7
         smwAFkI9H0l6HPhe6evwCVBAvAA0R87bbntItDoiNKil9qrgtVj/iRE+3Mhft/N3dAiU
         6kmN+4RgKL+h1L5vVsxlp5tNJOIxw2LgZ8CNlE/3RtL/SmNpEy2q1EL26i2Z09oiTW4h
         kTYW5gguI7JN+P5KliR7R5ssMozJ8L5h10K6aiB+i+hrNZ/KitpODzIX4pf1WxnyDX0Z
         6oow==
X-Gm-Message-State: AOJu0YzhHcRxNgc2kqgwF9arLthLOE4rWlLVgpc94LQK4Rr3qU3uyble
        LwO4CJadT8rdNrf0pWvRiF3GCOPET6yW7vyyEw==
X-Google-Smtp-Source: AGHT+IHdZWmZVZ8nR+Gj/8vlHj4D4vBGEDW/cGZY+OvJ2Etb+PzlTbRHanhxFkmiI6dNbhpt+jQJ8D25+v7P5BuVQw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:289:0:b0:d7f:4ba0:b5da with SMTP
 id 131-20020a250289000000b00d7f4ba0b5damr245965ybc.13.1694465469971; Mon, 11
 Sep 2023 13:51:09 -0700 (PDT)
Date:   Mon, 11 Sep 2023 20:51:04 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALd9/2QC/x3NwQqDMAyA4VeRnBewLcK2VxkeahpdQLqSOFHEd
 7d4/C7/f4CxChu8mwOUVzH55Qr3aIC+MU+MkqrBtz60L+fQFs1UdkwqK6th/G9JrMxxxxIzz0j 4DANx58bgaYAaKsqjbPfk05/nBV1Gb0N0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694465469; l=2003;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/KG5GaNcu8MUTWe6zZ15CBm9Lw6GIS3IVGxfb7J29/g=; b=qtp5rDmw7oLdi+J8HJfF79nA03GdYz27dAA6BVE2oZatoY8HvOkCZZaxvA7beHrToYCP93/pC
 b4PZP3DQzmbC/Mdobs6jOwUCw4MuZuZM6CW6uVJH6gCSEQlvi7mGD2U
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
Subject: [PATCH] auxdisplay: panel: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated and as such we should prefer more robust and
less ambiguous interfaces.

In this case, all of `press_str`, `repeat_str` and `release_str` are
explicitly marked as nonstring:
|   struct {	/* valid when type == INPUT_TYPE_KBD */
|           char press_str[sizeof(void *) + sizeof(int)] __nonstring;
|           char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
|           char release_str[sizeof(void *) + sizeof(int)] __nonstring;
|   } kbd;

... which makes `strtomem_pad` a suitable replacement as it is
functionally the same whilst being more obvious about its behavior.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/auxdisplay/panel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index eba04c0de7eb..e20d35bdf5fe 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1449,10 +1449,9 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
 	key->rise_time = 1;
 	key->fall_time = 1;
 
-	strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
-	strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
-	strncpy(key->u.kbd.release_str, release,
-		sizeof(key->u.kbd.release_str));
+	strtomem_pad(key->u.kbd.press_str, press, '\0');
+	strtomem_pad(key->u.kbd.repeat_str, repeat, '\0');
+	strtomem_pad(key->u.kbd.release_str, release, '\0');
 	list_add(&key->list, &logical_inputs);
 	return key;
 }

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-auxdisplay-panel-c-83bce51f32cb

Best regards,
--
Justin Stitt <justinstitt@google.com>

