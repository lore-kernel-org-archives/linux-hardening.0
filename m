Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94B315D2C
	for <linux-hardening@vger.kernel.org>; Sat, 27 Dec 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837880; cv=none; b=niJW453kIHoFE1Z+n5cZUzsSNxposX6TmKhIDD44ZLf7jmPBXo6uqgOQRWu59ngYDLhr7aXkTLvmKEtpkkMCsGQh5/ERWh7BeTU1FiIYAEciWi13ES65TBRfwi8Md+fAO/epZ8BSDz00KKkqx2FwA725aCMW8ZJaqOXYkCRkcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837880; c=relaxed/simple;
	bh=oiRJqd24xNJBRHp4bn2koH7CqQq/f2UmEpMOGnQzYhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVuoyFcmvlWlsJXELiYe3txkmJrrw1Zo9V95FeP0d5+MkDDHbloa7D0anoESoZq+P7LtFMG/9lY6bGXeA60MQ71iFhYt+1ng6eMPElWwD9YvuRFsOdF45jSU731RJFALCfcdXfyA5K91EKRKN3ax3EL/FP61EijGtA1kCjXaAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bqhCR2Ep; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bqhCR2Ep"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso80635155e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 27 Dec 2025 04:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837872; x=1767442672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WVQ5l6OvuwNcTcqNwKXFrwDkeL8FFp17NQ/ZoKZRdE=;
        b=bqhCR2EpXLgE9XhZI2hiZEPRB3n5r5OlzMOb9+L3gWNCQ0G+4Sw63quX08cvfNhUj4
         7S5EUvA6p5KaP293DvxGfw+1LRUwCv9MqA4vdLqhwK3VPhFu0eGSoZS+m49Ty6DvcSGU
         LFxHzrsOaUWacQfesOju5lG8NxWBnjrsC1s5Bm01xToejDk/uYBPO+OqNm9vpa12Ge6L
         IfctQno8izT5lZAB7Ob/tkthX3WObdogL3Ib5eyXYyXilxeMRc8O6xQaAzhyxRSSQKfm
         0WGFH+ZuJ0Jn3auPF7AmdegCgkbK7Ez/KbUBb86G7NnnsM4k9razjzp3Z9hXG3c3TMsQ
         uHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837872; x=1767442672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WVQ5l6OvuwNcTcqNwKXFrwDkeL8FFp17NQ/ZoKZRdE=;
        b=PJPj/46w/WtC+1fWzkf+Mpc9La854Ac3Z/etxC8szQ5WFpTpkUa1g9snY5gYE5MYCL
         VvwRtEgQHQpHClFp2Ngf3qjfyjCZkPUGWAEsAvDhgOpTzo97RFhX9PmeF4GBo5VitNl3
         iYHbDp5unTnDbueeIS8oj11cBKV3NpeA0TJdi5MmFIjIRz3xLzeRzJhcZwmj0hmZA67f
         UGG89c020L3AT76MIDjva93ZQYTn0d4xMxe5oeYVqF0MqQPuEjgobzWB0zp63TWBEwgL
         41nnas7Kb7EbFtH5s8JM66BI2qss11KMYLfXHfstcglOjTi52txYo3L6DPNqH/nEuv6C
         p+4A==
X-Forwarded-Encrypted: i=1; AJvYcCWGLeQpSj9fPd39hkLHdv7voSxKhHEwNVYUeNvbtjvMQcFvoHUHMrgVLWPdI3q804GGyFiLsriBslOit3I5b4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSS6P8v7V7lgTD6pGaINtMYmi8MBdd+SC1b/mAQo19Yq2YfGT
	SnPK3q/jPP6u+onCKpAEKdb9oG/Emmb53PVU+xjQvN7lNwoMExGXitZV4LWaABac2Oc=
X-Gm-Gg: AY/fxX5LP328MO4zlAtZJCw3OgVPqykzTwx3zdP1zoH4TNhry8qT5B3+fNvdjuVggjB
	tAqv+eosPQ++WSf09kstSFaeGx1ekcNRS56thnIiWhXQGJK8oT0Fp/YoerzX44vVY1yQItvezYd
	Tbi999yCph3Z6/EsLkW2kKKS7lpqCNlNCNsXeY2RfqRiBadVRSZWdF1OmSmRomZsctAWMYTHb8g
	6OlgylT686zobh67OqydNiBY8hCRzVowYH4fMhedyO3g5iN9kiv9OnlCi/eoycrURsb5cnMfkhs
	80AFQcI1kbjOELKvXf+TKRbE75pVtozCiDFb+pLeuRTdV25V6hFJbn2Y+h0uUzWsv3lccO5GcHB
	YXFp6oxhuKmDB4HTi1Lc/Cie5673hc/74cdlCSnxih+Bdw1Fl0KGJ8cFVa+9JEleIIM5tCETb2d
	+L/l+N+SVP
X-Google-Smtp-Source: AGHT+IF/XDCpzgWo6CWLRHeKJmnECzN+dRl41jhTKGOm6P2nA90X9/hReUsAzbYAQmyiLuP2DWyXTg==
X-Received: by 2002:a05:600c:3111:b0:477:b642:9dc6 with SMTP id 5b1f17b1804b1-47d195aa79cmr275082695e9.34.1766837872067;
        Sat, 27 Dec 2025 04:17:52 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:51 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:14 -0300
Subject: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1917;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=oiRJqd24xNJBRHp4bn2koH7CqQq/f2UmEpMOGnQzYhI=;
 b=PNCcHQvlH3xv93I4pBS5nug5ofRvIPVdGmJf0P9wllAmoEtQiq8Up0JT6yGQIvoJ3BjyCDLfA
 69PIUeecq2AAR6MO/z2xt/dsbeEPhnFU/DPDF0NwOHQtgJdH0eloVGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/net/netconsole.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..509ab629d95f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -583,16 +583,14 @@ static ssize_t enabled_store(struct config_item *item,
 		}
 
 		if (nt->extended && !console_is_registered(&netconsole_ext)) {
-			netconsole_ext.flags |= CON_ENABLED;
-			register_console(&netconsole_ext);
+			register_console_force(&netconsole_ext);
 		}
 
 		/* User might be enabling the basic format target for the very
 		 * first time, make sure the console is registered.
 		 */
 		if (!nt->extended && !console_is_registered(&netconsole)) {
-			netconsole.flags |= CON_ENABLED;
-			register_console(&netconsole);
+			register_console_force(&netconsole);
 		}
 
 		/*
@@ -1917,13 +1915,12 @@ static void free_param_target(struct netconsole_target *nt)
 
 static struct console netconsole_ext = {
 	.name	= "netcon_ext",
-	.flags	= CON_ENABLED | CON_EXTENDED,
+	.flags	= CON_EXTENDED,
 	.write	= write_ext_msg,
 };
 
 static struct console netconsole = {
 	.name	= "netcon",
-	.flags	= CON_ENABLED,
 	.write	= write_msg,
 };
 
@@ -1971,9 +1968,9 @@ static int __init init_netconsole(void)
 		goto undonotifier;
 
 	if (console_type_needed & CONS_EXTENDED)
-		register_console(&netconsole_ext);
+		register_console_force(&netconsole_ext);
 	if (console_type_needed & CONS_BASIC)
-		register_console(&netconsole);
+		register_console_force(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;

-- 
2.52.0

