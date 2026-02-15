Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102D1E1A17
	for <linux-hardening@vger.kernel.org>; Sun, 15 Feb 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771181554; cv=none; b=QEv5vbpthzk2QFdiVxFeOLeSEFFYWjwoVXJZOIV8okEaU8M3g00DmwKpAdiZuBAJEwWbVWuMqWxDeIbwg0hkN+ngC0GQGhjjtZFVsWKcrRJRMDQCTk+mjGo15ny8ILEm7o4ytRX+2X/hpiCRprL0e8UNMNQlmeEgQXvgD0szOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771181554; c=relaxed/simple;
	bh=NoNskTe3uZW4RgcxjeNpjg/9c7kZ6FWlUlEfAyhmGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+IAilSJikD1d0j/WR2w7vdKop/lwi4BLfVWzOo4kd0ROK1toOpF3sENI6S0EBFDQBFmqhsONSfRGSDTwqsQxDzwCgar1+5cSjoX8ZD3KZbew1XcpEwzRBuVl6xSDwgP6dnG+BW59KfOifEBnow5RjrYwZssdLIL4Lofm4h++jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMGThPyE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMGThPyE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ca01dc7d40so271344185a.1
        for <linux-hardening@vger.kernel.org>; Sun, 15 Feb 2026 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771181552; x=1771786352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsfzKYmpLSxAAOTiptt7aFVx1ktWi2rGfqaYFT6oD3Q=;
        b=SMGThPyEWfxaa8U9PKlPyLmaQ/Wmp9rzH6U6QxYwUZPiMq1S0l/AEahnWcbrBh6hRc
         G2seRBToawPiC7DGAJMRj9WMxLd3jZbYULmNmKGX5Kula36ZSDPGF+uLvgrZgpe+zkBa
         lfZfzatsjb78aIHg+7MhqeupKEdbtAfl3cm+SK7TFlEOE9jCHE9YsIkJXqMQMN2nZ7a9
         /dnny39dXsoxNdd1ojVI50jwCv3zGTs+Q0Y3oZSlv1WDaxyTSIClm+J/8j0xHNjM4YYu
         ASkbbQRuku0O7T2g2ncfwxvfY32pAfgeqIcPkDhrAqeXXBDLxF2BoU5c//IbI+fn11N9
         pb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771181552; x=1771786352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsfzKYmpLSxAAOTiptt7aFVx1ktWi2rGfqaYFT6oD3Q=;
        b=H1NSP2kKRBarkLMPoy0EfoPqOPrRsbsrV5EF6QqPI4qIBxvYHeu3ooleBc5ovXWOsq
         Tmz/g6PH8SW+pVmELiEz8/UzUFfi1a1PRb9LrA+81J1AvL933hJta+967AIoFS5ROKA7
         H3EV1thin8pom0zb6QFQBV2UzrRgRabzk0+qUbK9HsjzmcYoxTK0YyO8nqrlC9AYF6jw
         Vkd+PNlHbN+NHpn/oRbQibduAsSSNG/aTsDtlU2IHB60AsAobuformSawoLUxQib83sh
         eZTGoKjQduYQYq5nQpwVAWFIDcnvhGw3ZgwyOeq794bEFI9nudR3Agw6OBLH1+Sj1fAw
         Hjzg==
X-Forwarded-Encrypted: i=1; AJvYcCXhGbbkKlnB8AWwFYmjNFtpolw2fW2Q5PJwfHYBjMhAXlbOk9q3K4GlCjzWd1CfweJ+ZUbai+2fAKwtq9IRn9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYYXoR7QsHh34CgPgg56SiSC9ITQDmPsFN8HaJi0FpC9ZembB
	iZYghYkNTH3swt+3VyzVX/lNf1KqO/yarsvT1IRfrjUQuZRg7xZarSy7u9Zk+w==
X-Gm-Gg: AZuq6aKCNLOBksBq0/Y0Sbkb1OHOg0L1DhItLDnvrCq6Ur+kNj6+ekChw9LtNLRbh8I
	4H4EDnP87Dqf92JqCFApg8msl0VWZjGcgS4Lqfw+VqHtArkKmoeNlTnKJIBdOpSWSzlbzizLM/8
	tsrKXZAY4cwTI+4sLMMFQ+aNVG+r/JqfEfa59fonkKlroidFE/CwxC38UTFIO4FvITzznlj3HqH
	f0teF+hs7sHUrm/QA3mVrzPNaInE8+g8egZRg4gnmP41BZSuJID9m0IDOUYnPpcYwtInvXoz6CJ
	4a11MJPNwL+7+o+AK0ktCBSOtFMdikgqr84Gx6/OC9n97KtKVNlaSuVYSvFKMXIwOleL0/8EjST
	juhZJK1VQjS/rcJdaKPXkw28i7faF3Rl8F3Rr1RfqKT5Gi9m/u/LrMyo3k0xBpUOA0rZ2LntRwp
	Ub6TLzZJev0k4dyD1K7z4kVP8uVQ==
X-Received: by 2002:a05:620a:290c:b0:8b2:ea5a:4149 with SMTP id af79cd13be357-8cb4248158dmr1092505385a.65.1771181552160;
        Sun, 15 Feb 2026 10:52:32 -0800 (PST)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8ca6esm113306766d6.33.2026.02.15.10.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 10:52:30 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] pstore: fix ftrace dump, when ECC is enabled
Date: Sun, 15 Feb 2026 21:51:55 +0300
Message-ID: <20260215185156.317394-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

total_size is sum of record->size and record->ecc_notice_size (ECC: No
errors detected). When ECC is not used, then there is no problem.
When ECC is enabled, then ftrace dump is decoded incorrectly after
restart.

First this affects starting offset calculation, that breaks
reading of all ftrace records.

  CPU:66 ts:51646260179894273 3818ffff80008002  fe00ffff800080f0  0x3818ffff80008002 <- 0xfe00ffff800080f0
  CPU:66 ts:56589664458375169 3818ffff80008002  ff02ffff800080f0  0x3818ffff80008002 <- 0xff02ffff800080f0
  CPU:67 ts:13194139533313 afe4ffff80008002  1ffff800080f0  0xafe4ffff80008002 <- 0x1ffff800080f0
  CPU:67 ts:13194139533313 b7d0ffff80008001  100ffff80008002  0xb7d0ffff80008001 <- 0x100ffff80008002
  CPU:67 ts:51646260179894273 8de0ffff80008001  202ffff80008002  0x8de0ffff80008001 <- 0x202ffff80008002

Second ECC notice message is printed like ftrace record and as a
result couple of last records are completely wrong.

For example, when the starting offset is fixed:

 CPU:0 ts:113 ffffffc00879bd04  ffffffc0080dc08c  cpuidle_enter <- do_idle+0x20c/0x290
 CPU:0 ts:114 ffffffc00879bd04  ffffffc0080dc08c  cpuidle_enter <- do_idle+0x20c/0x290
 CPU:100 ts:28259048229270629 6f4e203a4343450a  2073726f72726520  0x6f4e203a4343450a <- 0x2073726f72726520

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 fs/pstore/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index b4e55c90f8dc2..9c2d5e5f31d65 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -74,9 +74,9 @@ static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 	if (!data)
 		return NULL;
 
-	data->off = ps->total_size % REC_SIZE;
+	data->off = ps->record->size % REC_SIZE;
 	data->off += *pos * REC_SIZE;
-	if (data->off + REC_SIZE > ps->total_size)
+	if (data->off + REC_SIZE > ps->record->size)
 		return NULL;
 
 	return_ptr(data);
@@ -94,7 +94,7 @@ static void *pstore_ftrace_seq_next(struct seq_file *s, void *v, loff_t *pos)
 
 	(*pos)++;
 	data->off += REC_SIZE;
-	if (data->off + REC_SIZE > ps->total_size)
+	if (data->off + REC_SIZE > ps->record->size)
 		return NULL;
 
 	return data;
-- 
2.51.0

