Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080F4F55CC
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370557; cv=none; b=QlKWTRTN0v4NKUlIHBcDdvMxllbgBNBTJiRlEpmP51woySnw5LUCo2T2aULfBr3JpAooQLTVnYmdsmUGo7drOP/py/sz/rWn1REeUTUk0A4FW1fdROdQvjMGZffW0jAQ/8oH4l8vkQdxCckhlH8bLtyJ+4I7Cp2IMs8X54Xz0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370557; c=relaxed/simple;
	bh=sQu7/0fi62ZQ9XV/rC2dLD1jlmGus/lbm4Uepx4HqUg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JphSbed/vNfCDVltUV+yykV3OtsZ2YGY2FFTHrdZ4aAn8R1EFyns6gDYUMMnvinzmS1oo95EZMb3c1RSNkAHZBmQLH2dAeeMR7b3JvZi+Gq3VIw3uO1DAXCVgdUBHDMGhmKl6HHPy5JtY5XFIhoEdQ2vdG75KFPtUCupyjSrugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwi+xEl5; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwi+xEl5"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so3373960a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790370555; x=1790975355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxvoww2RND8pvTVP1dZor0+GTIlQncozKtYuhxF38ww=;
        b=fwi+xEl5dnoUY+cYv/1LNruUjGLzIlXDYtLWtuGq2rzX4D1LLu6HoUwz/dAL9YbRiK
         cTXcrmdThaeXQUpPCW9yho4T9A8HagPYZHkzK4NNP61barts44aWXyNucQcL8xAKNWqN
         ZyH1oMhwz8aJ8rzavc4GQwYp+4aWG5l4zBZ4gqv8HJi7kc1c5dTlPF9K9UzNi5GGZwDf
         OaJtKmhZN9sbfiKbp+ThyqcKT/0VQwmU7haMuH7yYW554U9LtyziZl7h+FmOzwZLdE+Z
         RxNKOqD6MUEVhZ+PtHNKcC0j8+KzrC1GYB07mMF5PX1AgyO488Uj73jNSXsMv5YvxuVc
         rB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370555; x=1790975355;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxvoww2RND8pvTVP1dZor0+GTIlQncozKtYuhxF38ww=;
        b=kHpLKbNGrkIro8oAArpVRiFg9pQpNt9sGjzbc1YhJZs/rxMT04g7a/8IxfN7WP+opL
         +WzdXkP4qey/QKaXtd67CxdP/Cz7IARjsZSZgVDG7wx/8v4NNsZvoufAKPj7Q+lEPLFF
         fNi6tExV56hn9NyjjgMKQN6+Ou/A64MIttA10JoF3NsJnH03ttO+80D9SdzDB5/Xyfmc
         1++ebxETL8MkD9tlYKz1AJLH913H+zbRQft4ErFeiJb8w4dwsQg8EHmm6bscHdWaECKO
         8dSqjDLuFbVd0WPYV/WsR3vsY9RDYJE0IlB4cFQKAE0GbSM3eWERDeOavpMJN4NgO2Cj
         hvFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJWWJp61phcE0TUrIIONQ9ZE74dkZauIPn0Zqw0Uj7azpOx4F1wGihZ0GhcT4RBgISh+5t1+rz3HDdKZjRB2I=@vger.kernel.org
X-Gm-Message-State: AFuF++nwmk8smyU+asJ/G3cf3bZFqlvoMmvwdeMo6fW0ch4ixmj5m00h
	Y44GxbJX2tMhbBnVRoOUcjt1pCfVzNCqY6jZEfobRzgwuIlzpNmMNsLWCe5Xn40mf9Z8h660SyG
	h
X-Received: from pgqs12.prod.google.com ([2002:a65:690c:0:b0:cc7:5a7a:c5d9])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c49:b0:3a0:7d60:450d
 with SMTP id 98e67ed59e1d1-3a098feb5d1mr7042271a91.43.1790370555057; Fri, 25
 Sep 2026 14:09:15 -0700 (PDT)
Date: Fri, 25 Sep 2026 21:09:12 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925210912.113052-1-morbo@google.com>
Subject: [PATCH] firewire: core: add __counted_by_ptr to struct fw_packet
From: Bill Wendling <morbo@google.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

In 'struct fw_packet', the 'payload' field points to a buffer of size
'payload_length' bytes. To enable compiler bounds checking (via KASAN
and __builtin_dynamic_object_size), add the '__counted_by_ptr' attribute
to the 'payload' pointer, associated with the 'payload_length' count.

A thorough analysis of all allocation and initialization points for
'struct fw_packet' was conducted. The pointer and its length are
assigned together.

Because the count field is always correctly initialized before the
pointer is accessed, the '__counted_by_ptr' attribute is fully safe and
will not cause runtime false positives or panics.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/firewire.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index fd35a6570cd8..9f313b47a694 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -322,7 +322,7 @@ struct fw_packet {
 	int generation;
 	u32 header[4];
 	size_t header_length;
-	void *payload;
+	void *payload __counted_by_ptr(payload_length);
 	size_t payload_length;
 	dma_addr_t payload_bus;
 	bool payload_mapped;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

