Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE614314D26
	for <linux-hardening@vger.kernel.org>; Sat, 27 Dec 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837906; cv=none; b=ibz2oGrphJ9afY8ViwdmHDXVY6JjSXJ8s61XhfGCZncu12bIzb1l4YEmEn+7g4ZScHFSh4w6eLdMMZdb4PpvK/Aucvuislzdt7st5knq+D928r5WiuvWD/SDS7nrfSr1BU+2MP17nEtqNpHd0sdn6uzcIvQ43aT4aYHwItKfQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837906; c=relaxed/simple;
	bh=3dvgtN1V/Te+qiB9DfrS6Ouyxfyny3L7qK8ewpooDVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ob03n/uCH6eNTgbpsZ8Mnr06PItuZk+YwbCzELXSmD8FQSaxXvV8FeDRozmzFCsCwiaqzmM1P7SF+5+uGSY+DkXeEvZZgR4t9YQ9HD014VHdkejRhmUAHKr7Zp+vaSCH5EkfLfht1yjxUfHwKG8DLB3fRj/nDsN4dbb+zdLLpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H4RzMJ1s; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H4RzMJ1s"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477563e28a3so48214305e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 27 Dec 2025 04:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837900; x=1767442700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=;
        b=H4RzMJ1s9ZwnjJwrCnWnd3j67LaiHjYoBgfV2z1wnIf37T26+DNg5xDvlBjEVE8otJ
         kZ2dI5l/t4QZvlxSC0mWNKPvut1LsMFF223IPd5HHbNU+MI0qNCyZpKdRWRBFkkgH2JN
         D4ALpdc6KHDsnkmnIPvWgWlbSPpi4qQh7OTavOKNMR9DmGdyqwzp0HJDRAvDoEUJ2zR0
         GYmHIBqq9o4goE5t+JVhQmH1QNH2gj2cIpx9Wv2aAkq8rGei/TSRf3gitnBTzBEM7vf7
         lFxjpO/zZWifNxpKD9YEe2cdMjk7ljAuds+wwBUmEg00mYAJLSAPHVb09/YbRaR1i+/Y
         ePuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837900; x=1767442700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=;
        b=FqUrgfIoat7r/xwWQAAcPRMlWJrgB63bWDWj0MnRdCJ4l0E60qcyCmywAkA6XFrfYe
         AKo4idoCiLdS0eewM1rNdXlcBhPuB6miPFoeVvjRshP7Hrn02H+Kn0oFnnqz+akWVkT3
         kRbDCOTFxlOK5+85x63o2/bAlC6QkmvhqyfwZ+KvB8pn2e931hHqMTzrBcMh7QcdMq98
         cRKkeT4lr2NWsBcefkhhYgRVc/OVj4bXqHZaPSBVd6NOXU6/FirpVqmFfWdPCj8vqo4a
         QHoNFMgBeggKKt1gfEGVqctrptM5+4S5EHa4prGJgcRfEOLDlhaNbGa8aKTNCtzz0Pof
         7G6A==
X-Forwarded-Encrypted: i=1; AJvYcCUhVVZM3J897m0e3ekXzOFKt0q0Ws34kLGBIZ/ZaRJ8XFHEPAc5eC+6EdWvJ9gw81gLNNKTXzqgU81m6Nkn/Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxYFoQyQwDqGdAB0M6BeC1DpfDV4irzfk5Nle7vyzFyK15iFG
	+25BtVwGY3RTCTE8fFFILQNa4mgKGtOZlq1ih2QrSfRrDJMyLUowthC1MLVNki4Ze7A=
X-Gm-Gg: AY/fxX4Fp9VBI3co1gZoEJXosF8CtZq23IFq0KLUet683FLArPvUo5R10GgesWJ3G0m
	HMQcqbloMNBAxQd3EYysCaRI7Qw71+MUCQ//MaXG9SSDpeSz3CP9RE/dym83aO2qbA01t8+LFQ5
	SBZycCcR57ZuZQZQROCquZVHTyTslea6P31BWhXbASfkp011Gkr5enQLyw1GimZbDzEPTRiLc/2
	3hZGY4H9iVO4/mvHimtRslBGrJiDq5k5mHIBmpUk7wrCqYiWfwXT7xGwREV7GdUdEwjpHTvEY+w
	JOzd2YwAChY54GnvsrqEufDTHw7F6ctYuxVZGsqoce8UQOmp9q6O8vRTj5J7eM1NMhvjYei6/BR
	AfEiv5K7TOFFKW65Bt+q5xHjrbmtPZQGwuXlevw3cmytpKDw4K7OqAoWK2wTrdqmskaSKwvzjTo
	GSaKrUo6yH
X-Google-Smtp-Source: AGHT+IFXI+q7UVcETj2xrgWEDOplaD2DQfL+z5FfnKK5mI2lAjBc9EF1caRTkYKVAlNOUIoqedA3Qg==
X-Received: by 2002:a05:600c:4d98:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-47be29f362amr221645875e9.16.1766837900191;
        Sat, 27 Dec 2025 04:18:20 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:19 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:17 -0300
Subject: [PATCH 10/19] fs: pstore: platform: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1079;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=3dvgtN1V/Te+qiB9DfrS6Ouyxfyny3L7qK8ewpooDVE=;
 b=vEVEr1V/PLyTXU5DKxPct4kmpsEX80YaTpb8m+k5Ll/RykRPcPf3SC/5piYXBTRWgZnh2jkWP
 FQP0jQiJpLBB9Qo/wJGJV1aoieFgYcnUso9xzkOCnscVwaYm3IY9A0b
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/pstore/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f8b9c9c73997..9d42c0f2de9e 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -418,10 +418,10 @@ static void pstore_register_console(void)
 		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
-	 * calls may have changed settings (specifically CON_ENABLED).
+	 * calls may have changed settings.
 	 */
-	pstore_console.flags = CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME;
-	register_console(&pstore_console);
+	pstore_console.flags = CON_PRINTBUFFER | CON_ANYTIME;
+	register_console_force(&pstore_console);
 }
 
 static void pstore_unregister_console(void)

-- 
2.52.0

