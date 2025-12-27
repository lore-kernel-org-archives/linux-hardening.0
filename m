Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5631BC91
	for <linux-hardening@vger.kernel.org>; Sat, 27 Dec 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837895; cv=none; b=DkFIXiyxHtqfcVJreIT6T5Es0bl7IJMGfHi2R9D8SpMoc6IZM4gkWR43VeChs8y6tkYG0JTfpCp4+PnBcd0TiaN0BS+QtrGd0KzNSuOVjzAY6SDrqGP2BWmf24gPaCDjEUpj+5PCjJnQt0h4NdcaDXbt13SYxnoKgNG3blzSyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837895; c=relaxed/simple;
	bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRbC4vZPmwGnzHXZqqvMHKYFh7EAGF/ZSECLAAi06zTysIRNZEH4HRadFt7RiIYiCxMw+gv/ivxswD5gF0XONDSZ5MtTx6pW6BMusTRulccuRbnB4JGLvmxQIXd8wOKRdSMaQI+feoj19zvXhy9QoUbDyqDRARI9QxdrlDRWpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TG47dukP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TG47dukP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso61935675e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 27 Dec 2025 04:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837891; x=1767442691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=TG47dukP7w13KTUTZ2mrQEyHmZIw1b67Qnqn/1mmqNRDGCiAKHY++6IMzQte7KyLAr
         BP9kpfYHtqsTTOwTNS8gGBSRy3+UJwj3DoBlWZ/ctuAbw0wRSyH7nuXoD/sCE1QZBnLS
         5hq6zbtHXR5n00KdiMrm2Mv7tMj5gkUX3+E8UDHBrZfBONKAtCmjatG6MROGzUpun7a2
         hm2h/uhigfCGKby0EirnGsqgP9aqtpTzCPmIMy2aOwThblrC7dgAvEXTnu8wn/rjR9YV
         7hZB07PU27uGvQGMJEv3WO6Ln/VstRVEEoWlWKTfdbrnuxKmgAHNe7Esfqboi9c2sEgP
         ehTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837891; x=1767442691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=lw3Sz6BrtlPgzGmU//2THmUHvJ5SiPNR8mui4eFOExZACJoZuddzInHmwMBIxtQswi
         I0h9iH5tXKjrBSR3lfbgqLPq43QfVp+w5h669OXU1/bwQ6QoU4xKJokBe4ncjrXF8ljd
         s5dD8RUBau1AD+2eEDk2AlasyyTB6ecCqzLHekfeFY6WXt9L+Rxf/8+K91m8wJ7yhW8z
         I7rJTIqpCzyXBBNqS3SqrBBi2237Yq/eHklrk9+YkoTFgBexLQU/i5OsJ18msYS1rHAK
         B+Sn6y8SegqeYgLhhJpC1kOBS6hzxXY2q4rCCCN7xNwxuUqCdzcANlhGMoICHYLWLK0s
         MWIA==
X-Forwarded-Encrypted: i=1; AJvYcCUvELsO5PlaBM4P+jON/y7Ua/glcM0kJe529Hz2vEj/ALkzNmj3/kHQHg/kxuQlFCkgVwku2X01B6mFQipcfaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd07d3sf2TFpjLh9QoDmcPUEwE3kc5Xu6xql90HpDG1+U7nUi4
	lN36SzPrLyAa2kIK3+N67nWEFWQ/RQsD4zphpZNvBav5g2zBFZ8gNnsrkZPNnAXzux0=
X-Gm-Gg: AY/fxX7jl8NqyhvliB9R15f6wT/2zPQnavLzG7nMH75Pzh7s5ALiQKQbLvj8/x1IwSh
	lEtBU7A1RJU0b0denonQTXVnOF5QLFQEiqzh4tnYrWGCfr+maPMmvRJ0qtj88Quy/Kb9HCo179z
	Gwk2rw0YiTTKQ59gROP4g/+mJH/46aucxKGiZvJynD/pnf2VgXAdGzQMqswjKF6rzVZAfW1Q3AN
	mE1lqi0Icm8E8XhGxN9OelUOtruhPepDAXDH2iQII7p8dmNrvOWbnQpclmf5B1zSHddzw2uCo8Q
	ui2R+u7949WkXaLLClDM3pg2PmBtIfA7cblGOMVSUL2YCIokwuCneM5OsasGx4ybOChcpgLgU2d
	HXyml3dWMB27aF8JCGSQRx5otLa9lkHimsKNfR2uFh+hhCMr/pvXQ1A2bQjUPbrcAK0VngiEyEz
	FAq+MR04Xn
X-Google-Smtp-Source: AGHT+IFJeR5Bq3e314KIMXwkrZhqd3SM0Gtgef2ZKhyuTvMEsyAQgTg0idlkENoTE/A1RwLAaI6A4g==
X-Received: by 2002:a05:600c:a30f:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-47d52efc7bdmr6320155e9.1.1766837890917;
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:16 -0300
Subject: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=997;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
 b=bFiYD37gtcultSa+DtuWsZDZsqldtTEWNQGlnO3f8qpUTnHo9LyYg6/jnVTrFnBYz5Wno6rCP
 MIg9mT6KNXdApenqW2Pg83sbMRC0cE454dAXf3m0peqNYruoithEiNk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/m68k/emu/nfcon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index d41260672e24..3504bbb4aedc 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -110,10 +110,9 @@ static int __init nf_debug_setup(char *arg)
 		/*
 		 * The console will be enabled when debug=nfcon is specified
 		 * as a kernel parameter. Since this is a non-standard way
-		 * of enabling consoles, it must be explicitly enabled.
+		 * of enabling consoles, it must be explicitly forced.
 		 */
-		nf_console.flags |= CON_ENABLED;
-		register_console(&nf_console);
+		register_console_force(&nf_console);
 	}
 
 	return 0;

-- 
2.52.0

