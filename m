Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED026281;
	Fri,  4 Oct 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728010778; cv=none; b=me5L4ISxmNd1qkC92d0fZTUSMQeE6NnQJId60VVTjwqypsMG5qAbGtVeMhZiFeVnfpjoM88i275hc/LpgXnZwtFdGwU9ija/AqH3RlOHTfkVmxICDG3C53L+AJwaSiipXK95Rb0mkK/dTnSOKsOKEaC8bW6jDFk53NdKl41qL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728010778; c=relaxed/simple;
	bh=84ujckkZ51GI43mB3Xl+5Ibt0WnQcALsHNHviOMN4QE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZQCR+W49xChN/Vn4KOc3cHLzIemQvE2Evjsk7zeh4MV3o0Z4CEM5ggqkAq1N6Ub+Flszb8i3gSE3oIsRj3KcIycbqR+l6vR0cUseaESH0hwAy/MD98v+/K9oVEjLMNcDhlTtbAX2ce2LIwgcWiCiW5w/AiZRzlv2dRhpVHRtQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoCe4EsB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoCe4EsB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db233cef22so1235667a12.0;
        Thu, 03 Oct 2024 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728010777; x=1728615577; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3NU33QKfsB47hS4uf2RyTU4prcTlzS/YFj3Qi75XHY=;
        b=HoCe4EsBbGjHfmvIACB8VMxSRl2dEv/kvmL+5bzxpndNqZWkgA4Tkp8905Oyfv9riY
         y2Y/6VCmF2Kbei67vuCy1MTiIro426AR6lnYehNXCOFsSiSp9V3AaA3fzRCtH/xhuGr4
         8tkWCIYEwDquYOSfXMNRzNCBY2RjLsBfn8HcCe5XZYSh2Y26zxay5q0aZIFRtZ+knqbI
         0vsZft6lolod52zvVu9WiY3vbQjazI/eOqDmkAwcTBrkzazGJ6H1ND0oidEeCEjadDLm
         jgI45glLHxbTAh2G6M/hHz3lnsE+6uz69DT/HXNSw5mgSe8n0xUZzlkuicP+bVRuGjuH
         MZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728010777; x=1728615577;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3NU33QKfsB47hS4uf2RyTU4prcTlzS/YFj3Qi75XHY=;
        b=AeTPTdshKqOcfPlNcnxkfrKO1jO5Kfz1wAP/Y6Lg+UooMflVuGwOLvzZ0npo9ahe0n
         /a4rrNK+snyzELK7GTBORKBpHi7p+3aoUZ+/u7HO4Zr2L+PV/XZ32kAL60Us6geVeZ+0
         ++/h+RvvsIE+/3O6qwZHGizjbHTORLud1hafMUY7Q0gDUOyLeuvGTdXvP/gyZBrVExph
         wdSrEhtzbuDjDSbSHs+5/FfgK+HoTfc7Lf1P6gJ/Nj1fUdgEYIcz5j9ZpXKUw0lv2BSf
         pl9HWIIIDxXDTUrB2hpkq1YoSYwY/Ytdn9teANbaIrZ+afWNQtFLNzU/AjBkB6Eb7IJR
         2aOA==
X-Forwarded-Encrypted: i=1; AJvYcCUwtGjXhD2Tzcm0x7Ubs4H1vmBbT8qoyDfPCodlElGE6wzah2tnxGHCmeUb6EmzP0w94QZBUHmKr+RlYkpZ@vger.kernel.org, AJvYcCWInS1OsA5moLFmvPj1qlWbyTLm8Ns+kaTyW3QhiIscXZkQbd/ieC1iYZSQbYV4vpmxQyQJDW88OgDkSST9kjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67/Qy/GhIq3XsiqZJyMLwyZnB+LKgqFvaAcjmfWfxiTRcMw1u
	bSKVrWnULlZpQ8hXhm6YSPASTC682bHAEZZnv03x9oMi5w518HJs
X-Google-Smtp-Source: AGHT+IH2+nbgvbeYemeG2wYutlDVYsTdoTHTGCYG8oK7AV3Pye0F2DtCF+aaFGmh2ybEkU4bzCPPkw==
X-Received: by 2002:a17:902:c94e:b0:20b:b479:94dc with SMTP id d9443c01a7336-20bfdf6aef8mr21467915ad.8.1728010776610;
        Thu, 03 Oct 2024 19:59:36 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef706fa1sm15363755ad.264.2024.10.03.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 19:59:36 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:59:30 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc: paulo.miguel.almeida.rodenas@gmail.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [next] ARM: Replace snprintf() with the safer scnprintf()
 variant
Message-ID: <Zv9aEoDo1k36Hg3H@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/arm/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e16ed102960c..9d768a93fb1c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -186,8 +186,8 @@ void __show_regs(struct pt_regs *regs)
 			unsigned int transbase;
 			asm("mrc p15, 0, %0, c2, c0\n\t"
 			    : "=r" (transbase));
-			snprintf(buf, sizeof(buf), "  Table: %08x  DAC: %08x",
-				transbase, domain);
+			scnprintf(buf, sizeof(buf), "  Table: %08x  DAC: %08x",
+				  transbase, domain);
 		}
 #endif
 		asm("mrc p15, 0, %0, c1, c0\n" : "=r" (ctrl));
-- 
2.46.0

