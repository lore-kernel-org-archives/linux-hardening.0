Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430D405D4
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MOG0FzW"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0364310C
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 11:56:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a2318df875so19599367b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Oct 2023 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696532211; x=1697137011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eydlxrPJ/pmozsTSySXLkFu7a53QgB4P2BhmOOld44E=;
        b=1MOG0FzWY+B28VfmpmiZ4Kh/e0fbmWDVf/kdCM2HUX5E5+HfYjFV37LBLnaWy/5+No
         UA+YEv2vZhyj1fndNxbx0jp+/nPJJUHfG06a4ok6EPNLTfl1Or8f2gl4maWvZQnAtwxh
         zp0efHFSC1s8doqXfnjyYnDurpqaSql3am9TWsIth22bpnigc5K1qkZVv875Yc1RnLgQ
         pD3ZGob00JamvjDbDR70My+/ShqIN5hjon6qXRqHLK15s2Qk7z9xWo6rw7J90jmHRt2C
         1+NojdXvk4apZ3/8QDd1UBg9Q2uoRsd80kHzHgxplBiPw6NiHomabLDnYV9FG55Wl46w
         SWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696532211; x=1697137011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eydlxrPJ/pmozsTSySXLkFu7a53QgB4P2BhmOOld44E=;
        b=Q5yNpS8VRlkKQkatkW/+uZ136ctL/S1WnmyyLOJ0s5cCpo3IeYrb5M2yq3eb23xjX+
         Q5iO8oThbtERID7TIi2w8YXbhGzpqz35XahrWOGONXwDlwrPwgF1IBG1YDtnUi3RzWG3
         LwS9voiF4F667VO9nB4mHtqUp6tjgPSVtnPw3+mwLr/ZnZwTIkq6Rul1Ve0fxXpE1uvR
         ZA1UR8vXtMtx8rR/LlNyojbsCUN6VDrg/33lUXKlhEbNGj+WQv+ddT2ZlXyG5tml4obe
         lmBv7gf/QitDz+55KWxB7KfxITT5HslGLh1UeajxuYHHP15xlPI8SUaf+LR5AbF0wD6i
         nPnQ==
X-Gm-Message-State: AOJu0YwPFmevpfxF7oy2rNnzFhM/8B3M0M7YlMjvo4zWWA088joctCvU
	7aLKm635UMOHu6pG82JaSa8XiCxHBe1oGcJE3g==
X-Google-Smtp-Source: AGHT+IGw9j1c4ZqKT+jP44Q5jYqURZViGdjQP9Qdf764azGuPvp2A8S9d3pmyXW8g/SwbG3OQxUJq0useT5bEpN0/A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:770f:0:b0:d35:bf85:5aa0 with SMTP
 id s15-20020a25770f000000b00d35bf855aa0mr99342ybc.4.1696532211122; Thu, 05
 Oct 2023 11:56:51 -0700 (PDT)
Date: Thu, 05 Oct 2023 18:56:50 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPEGH2UC/5XNSw7CIBSF4a00jL2GhyA6ch+mA0KvLUmF5kKIT
 dO9i92Bw/8MzrexjBQws3u3McIackixhTx1zE8ujghhaM0kl0pwriEXin5ZYaBQkTJELDBkB7O
 LN8UV+EQIHoyyxmqL2kvJ2tlC+AqfA3r2raeQS6L1cKv4rX8TVYAA7YzxWllxueJjTGmc8ezTm /X7vn8B+2ULJ90AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696532210; l=1964;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=WEPAms72jIcON0R+TEoyIAOUx88hgLlG4C/IGyOKoeU=; b=Q5u/lRzz9GPrsxR/C/lmVH9+BUcqxH7ZIwWb/XRDHgvWh3MZgzMpWnZf5WZVVLkGT9Swq4rEM
 N4zrwEiBjCXA5MFNEV/hVlnf6tFI0qkjSjJQ8QUtujKRqnDY/z7+iwE
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
Subject: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This pattern of strncpy with some pointer arithmetic setting fixed-sized
intervals with string literal data is a bit weird so let's use
ethtool_sprintf() as this has more obvious behavior and is less-error
prone.

Nicely, we also get to drop a usage of the now deprecated strncpy() [1].

One might consider this pattern:
|       ethtool_sprintf(&buf, lan9303_mib[u].name);
... but this triggers a -Wformat-security warning.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Changes in v2:
- use ethtool_sprintf (thanks Alexander)
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com
---
Note: build-tested only.
---
 drivers/net/dsa/lan9303-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index ee67adeb2cdb..95a8e5168c2a 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1007,14 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
 static void lan9303_get_strings(struct dsa_switch *ds, int port,
 				u32 stringset, uint8_t *data)
 {
+	u8 *buf = data;
 	unsigned int u;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
 	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
-		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&buf, "%s", lan9303_mib[u].name);
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22

Best regards,
--
Justin Stitt <justinstitt@google.com>

