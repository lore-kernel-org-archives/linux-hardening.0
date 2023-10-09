Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB13B294
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZH9r6R6"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E797D5F
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 11:34:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f53027158so72962677b3.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876485; x=1697481285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bM4vdckG8rnY8B9pZotgnlGAv6uavP2L8KjGx2+6gvw=;
        b=xZH9r6R6hvMY68Tiu3kpxICYzqQU7DV9Ehb/DiweNr4TSZB0dUV8rz1exoiibYEpal
         Uh7HGc7YYn173RlkOrHG94VBRnrNoNLHpUzDvnlJYKDdThv7A7Qne0fxigSMQ7NsMIsF
         wVir/Ab7d5KHeH4O2x8p07s28fAtSk6xRBzWVJvQZiK+DzOW0583kXdVYu/L3TBeknOJ
         OXYkXK8c9YkXO8SePZflGPT288tE+qM9BiWYl8p8Pcr0E93x5r+WpuuU0ambtsyX1j2z
         RG1Kzuaiv76PghMoa7D/L/5KF+pxj2zKRAiUA3kPXZ5ImczIScSkzIhmUCE7Bt6Ns2IK
         Z7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876485; x=1697481285;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bM4vdckG8rnY8B9pZotgnlGAv6uavP2L8KjGx2+6gvw=;
        b=eVflwMYe1DPC9EfVLw7X42HMVXPSQJOyPStCyfkasy449J9W3V0cOcqMf+lvIdj2XM
         azvmb1mP12oLq6DLP+aXklBS/qNX0kly9TbU6iyhp+lzqDwOE/KNmGDlJAmF0ihSE/YB
         +SXGt47Quhd6GJt5MRz3yePpIwiG1u6RgkPklqr7mM3iGJGd5kTXcDzzfuF7WO7lr3PQ
         DVmHw7b07xDjTEJxrMyetVbu+Tv16x5tlnAIfcxA9lbBNu/stLXJmAQ1nBHwDFUqCOb1
         o429poMxFJpAVPjey5Tx3lWeONir21Gc3x1nXMIEbWtFWIW1hkcZwlyugT5qgD+jN8Dn
         PwVQ==
X-Gm-Message-State: AOJu0YxR/hPFsBBCF4+fHzkOrPqHyQIp1OH3JPNTL1nYh2ob8RCi8RG0
	CFW2IWfMiRwpAukkQgDYE6M8A2V+T2jPgikZ8w==
X-Google-Smtp-Source: AGHT+IHMz+HoiK4CgCHFqTdRUktcbV79j9WV7kYPpy2lP7Lwe/7Y/FP6kzM8Y3AsOSe6R0NaeE49wvFHxld6DNL7jg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ca11:0:b0:d89:42af:d46f with SMTP
 id a17-20020a25ca11000000b00d8942afd46fmr249115ybg.12.1696876485366; Mon, 09
 Oct 2023 11:34:45 -0700 (PDT)
Date: Mon, 09 Oct 2023 18:34:45 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMRHJGUC/x2NMQ6DMAwAv4I811IIDLRfqTqAbahVkVAbISrE3
 xsx3HDL3QEupuLwqA4w2dQ1pyL1rQJ692kSVC4OMcSmDuGOvlqi5Ydsuok5JlmRvccvXXQfpDz POSEhc6SuHWIz8AgluJiMul+z5+s8/1JexLp8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696876484; l=1550;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=72/H5p/SqqXCeml5lTqSbORWxP5Dde/Rx27bjYoRkyI=; b=uiIFKsYNOtyGmZZuRJCdtAqcUUTlXBnxMGZ7beN4zUUJbUF5DJ7nGEjqPX9DJ4N7NrHcNyVwn
 5RXoS8GIPeZDyfLDD4QRTM4rqMjNrzqzx7FnEz2V2ZPC7M66FEmogNL
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
Subject: [PATCH] net: dsa: qca8k: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/qca/qca8k-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index fce04ce12cf9..9ff0a3c1cb91 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -487,8 +487,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < priv->info->mib_count; i++)
-		strncpy(data + i * ETH_GSTRING_LEN, ar8327_mib[i].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
 }
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-dd2c84b23bdf

Best regards,
--
Justin Stitt <justinstitt@google.com>

