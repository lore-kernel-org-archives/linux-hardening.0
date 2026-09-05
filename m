Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE02377567
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636570; cv=none; b=ZWTT82MgRuDZSJuKCRfHZNpovNhs6M6dRI5GH5akItaPGGVEpXlum0iN9UAZCWSc4/17hBdWzGhLb88T+6VkEmgN/j+3QkBTsauT4Htqw6SACvQ9D5pS5pUWc6MieC24SWIoF0+hd2aNm+j5cybSAAx/7yXtfix+BrIyW81R6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636570; c=relaxed/simple;
	bh=ipd5upR2TEicpga1iLZip+mHEfDMT1WpKFPSlKGjSaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOVCH5YZWvLReCzyMOAWhO8cofZVCb7w6d8bSFOy9dCc5iwsVtrNTbTi+SgDBe8J1we260p+5XTTQpv/Y5ElLR0IFSTJY/YhwU8qlm2ikjioHk8PI+r4Xf100/DLOwInjV2T1GdkJRXEl+y92a7zYH59fpAl/bxVB5kxIO2mPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpcSEKhr; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpcSEKhr"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66f79f58123so1874578d50.1
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636568; x=1789241368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=atqCgSgVfFJqR4IxbadjiI271vf2EWHpjmIlm326evY=;
        b=OpcSEKhrKAtKrYizCLc3WjuN/Alb5C3lqk7Kwg40NRdsOlpNQbDLXYA5cH/iqJrx8R
         UDpqlZcyrsh37+VqNmr/xQoKUxpAUG3t8lkzrdvFdubRXPCKee4jhm19nFhZOIsZb194
         Cfndra7zWVMJmh/M7RAil4BL+13oCZS4Pb5PAX6/pXsgadHtu0MFXcQwmcDjHXg7REYv
         JD7JiA+vv5AZ1/FpZbDfyfE8oZlxR59dVQOUf/4SH2LEpb1RBkf+4EPiAsR/mUXUBzKD
         bRd/LLU7e497NCMAQen7rnKGtEb0ELoMhBdrWoONcG4OvvuOwEfs7t7a4KKsPIkd0w/O
         2thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636568; x=1789241368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atqCgSgVfFJqR4IxbadjiI271vf2EWHpjmIlm326evY=;
        b=VbxK0eX+Q2QhtFa/RbBlOfzBBveNsJRAFs/EvIvjOfqBzuLnPq+nLLa9RaJ3lwglZe
         iVKoHH30MMLsX/9V0TRYF0x0mOv0pHDRKAsrRbQ/ZTJ/wsLQk1xr1nFbQEXOXi4s82pB
         xq9Ku4yo3TwEd4gSnuUtb0M3PVNXzfHsulbrfTAHfRkS7nL/3QfL2bXyJGGXzaWIl6so
         yzPkGyja3hAG4AioiSBypmpB7ZyfQSBSwKyJqoWc5vydNg6ABuZrlfx81jlOL80H6qS5
         DFFmGajXOS1CP5AmK7c973BNNGZvYpYxUv3FGhieoM6uFVwnXqUovmPbKhE82MsgtDCU
         PGlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnzGhIblyEOBFWpPhsDMowx+AOkM4K+JeXlO9I6Ctxycl1XQqP8C0AP5L91qkrN7mhvfmSQhVUMQxnWsn2/js=@vger.kernel.org
X-Gm-Message-State: AFuF++myLl1uogBzKw0yNTcsTuUGrSiQBREzEs3zLQn6bLqSB+hQgMau
	Wt5acWqFGyJ4Kx/BhzuffxP5YZ70e8r1SJCB2gInpPAO8Jr78LnAIsdN
X-Gm-Gg: AYBFou3k/RM9ydRN140EJ3hdd7L2uDN1p79Q5pQoSLOAHOmiv/9aPAV7We5OKey/DXt
	h5Riq/VuDDuDJhtU0jwT/cPR764CuFysyTrXXXgnXOs1dGUZHHcvGQpCj6aq3RFPeo5/8SKygOs
	s7h3+mG1drUAl9eRMkPNKZNNyB9yxLaMSba+KJULUS+l7GoZ8wHyUf+mYy7ciRdAVeOto0bk5OI
	Kqe/Ak9MNcxjN1CQ7iyjmzRevNuTtCPcRXOcDCVzACgZNCJMuGUn6bk2QH8mrry7ytoPIlTvfFJ
	jex3/1vC34ilv2n+QdlUZXC7UNEzcnIjeckjjb6YXk5XlOaRvw8lGVq25Rr/7JAM7pcX99yweHf
	L0lNmqyDZR0VV/7f/G6lwGJv82Pc71Qys+26A5RPmjxPKez3XYEsI/5NJ31bkBhRm3nVpYkOs9s
	I76n1vqDWmudUg8hGoV8NHD8QreAddAciQGTm/wDwe/hH4z/yWMjyidlS2+PF+
X-Received: by 2002:a53:df11:0:b0:66c:82b9:ae73 with SMTP id 956f58d0204a3-66fc1beceabmr1869927d50.46.1788636568096;
        Sat, 05 Sep 2026 12:29:28 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb497aec3sm4999866d50.20.2026.09.05.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:29:27 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:22 -0400
Subject: [PATCH v2 01/22] alpha: enter hardirq context before looking up
 the irq descriptor
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-1-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=ipd5upR2TEicpga1iLZip+mHEfDMT1WpKFPSlKGjSaY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E4+t2kl9wXTxDXhVofZ2/30lDO/v3/bsz10jojH+
 gu+n59mdnxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1sw0Z/mkUZfEcPl
 6Um9Okxx7ucbu/ffGSzHQnZcdr1b+fyXUwmzMybLxgkGgl2lTmobr02SHJE4dNu9K2sV7fxHlj6
 v0ewedr2QA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

handle_irq() called irq_to_desc() before irq_enter(), so that lookup ran
with the preempt count still saying task context and with RCU not yet
watching.  Generic code called from an interrupt handler should see
hardirq context, and irq_to_desc() is more than an array index once
SPARSE_IRQ is in use.

Move irq_enter() to the top of the function and add the matching
irq_exit() to the invalid interrupt path.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/irq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index 4a6a8b1d5a8b..5867a1655045 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -107,18 +107,21 @@ handle_irq(int irq)
 	 * handled by some other CPU. (or is disabled)
 	 */
 	static unsigned int illegal_count=0;
-	struct irq_desc *desc = irq_to_desc(irq);
-	
+	struct irq_desc *desc;
+
+	irq_enter();
+
+	desc = irq_to_desc(irq);
 	if (!desc || ((unsigned) irq > ACTUAL_NR_IRQS &&
 	    illegal_count < MAX_ILLEGAL_IRQS)) {
 		irq_err_count++;
 		illegal_count++;
 		printk(KERN_CRIT "device_interrupt: invalid interrupt %d\n",
 		       irq);
+		irq_exit();
 		return;
 	}
 
-	irq_enter();
 	generic_handle_irq_desc(desc);
 	irq_exit();
 }

-- 
2.54.0

