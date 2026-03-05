Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0D481B1
	for <linux-hardening@vger.kernel.org>; Thu,  5 Mar 2026 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750670; cv=none; b=hXpgqOzeE0uHzMocV9x0C64/Hyyr/NXJlWETxUymTxzmxSUximuwpi6nhf0CXEHc8dnqTtU3ishsHUa1XtWk3gG4HfSGw+S7kumUREXnonV1SV1+4rxvSb0Jnz8vADvQoF0Qko9oNp3cIqB227y4Ls7PxwGjBCF7VnPzJgPAO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750670; c=relaxed/simple;
	bh=QOGWAcwQbWELRqmA6LMTuYlSfOG31hPBr5d3ni6CWrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7TsflQCsbNcEXbPLa8kmtUY8U/ykicWttEYD16korGpGv6jo+JI+q7kyij6DjQyOMFUic3w5JAcak23ofvt4FdYFccXsrFCoktfe5nOYNnCD9shRAw8JvaDwmhGPGj1zX4fNqagLIHh95SCpJxIhcbQxHaFkAuOvIZA/gbYorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzrrJ3ER; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzrrJ3ER"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829781b2b01so1428203b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750668; x=1773355468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBOQeouQPHL68ELqihtmFwL1QfT6rkZ5FJ68dANzC/M=;
        b=PzrrJ3ERhPyD5WRSKr/mvb1eeyMO28qJ3x8ljT6YzNLFUh9mHPlA7uui4/KUHvaHXw
         aQ591Avk74Lx7mqsE/3+gD3T2KSX1OXdRqEAaNtVfVVimD6l6paSVpfF29e4NrlPhCxU
         iEQsd2oMmFtI3YFSfrjJk2gkBvTINdVBNaydzY9CVTzL9QANHH/nSdYHCPg8hWgTCtGy
         xb6UjmtccFDzghsOaLm1cRRRivcT2jriVddUQu2amxRbe06rt9Mj6j+EK/wGmhhCuhOB
         1Eoj01Hgz8bobSbo5KBZ4Axn1xWZMFF0tNTYHiGJUF1oxzkMYo6XJjpzVinQMBmqJs3v
         B8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750668; x=1773355468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBOQeouQPHL68ELqihtmFwL1QfT6rkZ5FJ68dANzC/M=;
        b=Zk5iuI0qDELgvt4WHU4tFpJlIuU7o1B6KVdH/p9xYtNGltKPdw7QxLqm8KnwdN1ecG
         YL2u4wm2vqXT8Lbwb+dUrbfinurewr5O9WV5jdzHRstGR3gxuPQ2J6fYlmK3p21WCgXP
         nA+C/VZHpM+d/qaoAb9vCE9n8vfEJfa6H6/GMwvZy62ThC8Uqs34D+t+HkY1MZ2MwTpf
         v7GMcHXoDi/lXZTS9E4+dBLa75mZKILZKXN5IIeJkVFs4w3yK6V3XncVp2+by68iKqhg
         PF0PsBj4N5Z2U4rwkiudpJHeKBQmXIJd7RnbxX+sWI2uhi2rshjj90XW7emTTxMah5OP
         zSoA==
X-Forwarded-Encrypted: i=1; AJvYcCVuEthla3BCGt7CeX7+94wKnUpRMqmgP4tnslhDiS9ckPKhNkoN4AoaNWhOoVbTcXtIUuxt9Ce4lhTgukmjkB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwvUxullib/7hapEvnTmeBdPxG4N3j6E5NFI5x+YvEwn4w/bn
	76xarpHBr1D5ys6PK54Zhqm8rVROu+JpLSkATCsb3WvG50IGFIaCGMN9
X-Gm-Gg: ATEYQzzf4/7ro2APd/b7AOis7YsCooYFlGwoCuVLc7FU2BGnuHXpES3ZLZf2LbsOKUD
	Pp9NiOonJfExp3k1dlxHJy4E5AeCiMNmlb99SmJYr2f9gyfyDunt/FTFjrG1ERxzXXH+hnDfyc/
	LfQ2Ft3TCU11EdtLLxNzbd/gXFIMoiaU2zDqgnhxCitkK2CxyzKmlEYjMbxx+KL7LDwn4D/drzr
	nPFNk7bKJz1ZoMWlgxBum77BhCjphmVulmw84b18jNuFd6t98AyK3qQhQg/X7i3suw1TGsIcjR2
	oqDlFZDu7NYb0qziJm5cQvQSeroZaUyFjYN0ZvAYi16szartGmGp5mWp6j3AuvEb4hCOWmPMXWM
	4iJL+3yRagqIZMKP3XiHZ0TG0V2B5r5dLCicss3mzQ5uMzZ42gzF9jgbhbWuFUE2wS9qGlqH0In
	IArA/RMeeEwEBgCN8/ISUHvqNMn1mEUgJ+ptjTcZtMnxL09SSPmpjsYA==
X-Received: by 2002:a05:6a21:4c11:b0:38e:9ebe:525e with SMTP id adf61e73a8af0-398590b51acmr141202637.52.1772750668423;
        Thu, 05 Mar 2026 14:44:28 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738877202fsm3565477a12.25.2026.03.05.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:44:27 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 0/2] mtd: concat: use flex array
Date: Thu,  5 Mar 2026 14:44:08 -0800
Message-ID: <20260305224410.14251-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation. There may or may not be missing frees here. One
allocation is simpler to reason about.

v2: fix mistake in counted_by in first commit directly.

Rosen Penev (2):
  mtd: virt_concat: use single allocation for node
  mtd: concat: replace alloc + calloc with 1 alloc

 drivers/mtd/mtd_virt_concat.c | 19 +++----------------
 drivers/mtd/mtdconcat.c       |  5 +----
 include/linux/mtd/concat.h    |  2 +-
 3 files changed, 5 insertions(+), 21 deletions(-)

--
2.53.0

