Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F728643A
	for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120662; cv=none; b=NUtQTcSsz7+2SxdyZ+7fp7c7/1oSZAgBy355cVFM35+7+33DideE0D17ht+G7KrADrC2mO9k2QSQ5udwwua8L1KWQ7uekTIcdCOWirQPdUQ+eebFeUpFmyCEwuClEBrj1zZ4reQjwBlNl4G0PqYfbydCJLSEEEI4Hqm5r8+K+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120662; c=relaxed/simple;
	bh=POc99bc0onO/LriOLilIpL/JmvdIXpO6ppQHk5DJ8W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dm16TEGpAtkws2sd5Q50EFRIESmg75BWcZYZn4TgTLWxnXa2RTit2JorGnhxq6kBtAk1U35c92ZamYR8A5KMSpegFgKhVjEdfHVtOUE0KqqszJek4IGioR5aW4uMJH2nAPfBGHOcpTmQGvhqI1gIj4QzRYRTDVy/fUsXSBeyyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD36KBGG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD36KBGG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so3092196b3a.3
        for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774120660; x=1774725460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUDL8tQntpEJtlGp/phZgHmDE2I3nj2Jugu1QtrQteI=;
        b=bD36KBGGmVlHPBbyuyxHntHmBs+gEex2VyzCOpNiqI/Q+3O7r9xW8uswJLdcJNRQJl
         kepb8Ih4Zn8BYhjcX+/EncNc5xHcbLIor6yEZGYSafEnBMjHBnnY7v1tY7AwSxDkHJIF
         /s3pFu7LHOKDmsmfeHZtsQbpvqWW9wMuZbJJgR4539Ue8a14/5xtHTd9WF047kj4wC8f
         2M1N5QZGa52D3KloToFLVoj2HIO5O7omJjGljs5jHgK2xY1vtPTgl8eIjxpXsfTztIiL
         4RXfMavgPMindncg8zHfX9sq3Ob+YwbUE1U8S9rsOZcVx1Onk1lqASBHGVLoSK1Vcb+k
         ZISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774120660; x=1774725460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUDL8tQntpEJtlGp/phZgHmDE2I3nj2Jugu1QtrQteI=;
        b=aYbk8n1d1WUuKtDC575Q30JKLXzgXVkKOJjti8jaEA4XQfXOQYyysQSIXdq0bQOiBn
         D55dzbeiNXdAWuFhvyb4vlS9Nwp1FtQH1jv4lsHqDK4aYWFIWTBknMv5XA7XJQghgu9M
         vGQv4B0FN80QcflyPWUA5b5+TEdhZWxipidWxHxwQl0kOkbVAtRIUEMjd7J64QuQichA
         9SHe+PmRO7HPespXrjjq8oH0LVCEWNoVnnFkd6oIcoSJNkAwi+UlAZDK5qG+oEzO+dXJ
         0cCaoqPa1SxouD0jINiMDoZjeLR9cualhFer0Wsh/uo5d8NxTQxP+VzkAIesSGFnJ+HX
         N1XA==
X-Forwarded-Encrypted: i=1; AJvYcCV4E6Y1k/mN6CqmW4Rh3SDnoRU/7xeFlaISA+lCvROTJ754Yke4TZqgGMpy9hmm2MIMGarzqYPQ6GBuWj9lt78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeatL3khIAci/fXg8+vs53KNN2gFQkiHf3CFdYQ5c1XhmYz/H8
	oxnQs7+GZkFGs9T/iKQfFknOYMozM71D4UQ/eLyPkaa87GfwOC/eCjgaD0UJ9NSa
X-Gm-Gg: ATEYQzxBo0RZENKoVC11sPpzbB1TLNSQ6ABMK3rJBv0pt7/M2sB0acl6GwEQFRUCls8
	LdEa0btG1hMLuEfdPNJGZjbin+Bu+OHIZ+rZPygLuvcK1l/vufXktTjBxqkPzPoU/OJELcYqAYY
	vdMNYHFfZu6j63ERfNywRSlSKFw1r/8ll+3uwclhvFPgK+jnGU6RzoI1vZReLVtNPIg7t5WSUx9
	36m4BglIzR0707FRQ0fI1nKgO6NF2lHFAEQji4fXqPVu+7BVgpPaDVUwe+j6/+SvyZKFgge+d6q
	JGerpqV73R7fs3b0tfh0vBr2Vqs/nk9XjnFNAxgzd8ePZ3rqHkYL3wpXRNnPTC38KP5z8AhggkW
	DnSg0MQBJJn9xHQLPhEswe9ibIwu2O4uvZD4LGBKMGxBbqWAqNGt5EEPs3aEak+i2kM7ZpJvJrq
	7SOtTMfM8ZqKNGEX6IH/7AL3LnOyW1u89LcRxf3O1M/zDIYG1eVPjj3oQ=
X-Received: by 2002:a05:6a20:244b:b0:398:c0ef:e15a with SMTP id adf61e73a8af0-39bce97befdmr6563727637.13.1774120660524;
        Sat, 21 Mar 2026 12:17:40 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc9edsm4319968a12.23.2026.03.21.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:17:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 0/2] scsi: be2iscsi: kzalloc + kcalloc to kzalloc_flex
Date: Sat, 21 Mar 2026 12:17:20 -0700
Message-ID: <20260321191722.19235-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split up previous submission into two patches.

Rosen Penev (2):
  scsi: be2iscsi: simplify cid_array allocation
  scsi: be2iscsi: simplify hwi_controller allocation

 drivers/scsi/be2iscsi/be_main.c | 33 +++------------------------------
 drivers/scsi/be2iscsi/be_main.h |  4 ++--
 2 files changed, 5 insertions(+), 32 deletions(-)

--
2.53.0

