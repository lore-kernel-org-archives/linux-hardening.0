Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AE3242B8
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145570; cv=none; b=kGGmHPpGCtnrwB5NwM/9I1VnJiFaPp8weNzJkE6+dNllfPoryPXxVo3zpUZCTucfxlD6d0Bc0j0jzchaIluUqEWdECJQ6YO+nfxgQxExfeHcRCwUAXGsR9ZfYeL7+Zes8B19e4XTcHeJtA1UHPTh1+1TdzGtBRfRmKojokbgKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145570; c=relaxed/simple;
	bh=SR47e5VLRjptkH7hoXhuOEzDVgkJjAgGQHeZ6l3/JIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UbKbHizvK1d9viiJLERK+FDp2bEHtwKsgn6XwmpvSDOgTnWCCk8+WF5zeM/osRVsJmDg83gECv/oETmUFNn3f4FD3l9OJZmvXBx6N14vgorC9x9JKXXWo0rlySqWcS8V6HE+v9A/00l2NJubhg+8StkAo8mdlLmwzO1VppJXFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgblwmvI; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgblwmvI"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b6416441eso1013105a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 23:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790145565; x=1790750365; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fYXiK1IIs224YYvsOKYTsSB/R9PTPIaZUM4TNW3LiQ=;
        b=bgblwmvI2yMv+uyKXE+VRlWRoQxlbpZZAih5kNRxF3FlZwvMZTRZCa2LTSMco/uM+h
         rBmkIcygKMppxC+5FLvF9Z1yzH3d/SKHtCUuo0sTHTHP+DlZRuJwQKbyzBzX5wCli61j
         h1o/wQVOb/QgmUTxVsbSDHalM/dDoxOP91A8iFPSr0N96qzXnc3sGlD9G1dU8WhxS9Kp
         TLGCuiV0ytxmF69+dcDK7gpSdNS71UAXqMf/ev0DJFxbQ3u2SDswmJiwrZKHgUJMFRYU
         d7rIW5LtjT1Qo9y3S7EgY8FHWjhiT3ijQNwah6nFwGTmgPGrJ5d22B/jAxgy8pZwjieq
         8Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145565; x=1790750365;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fYXiK1IIs224YYvsOKYTsSB/R9PTPIaZUM4TNW3LiQ=;
        b=sVl9dTGyB0lc/Igj1aHz5eHkr1sms7q8t9KzEaCtTk0+gOf+5sBjU276n9vpgAVeTX
         GGjdIMb1CPV0B6InOEHEBbOPZ/wBXN71MYBMO5Fo3Kp1PDrP5FgLkBoGBMlya8+OSTpC
         o5gG9qO2KH72ZU30dCQmqoC10+/W0oZeBN+I3hmFYPtFqsqtvkwx1sYVK7e4f7a/gXVT
         9ZB3LAP0di8+kUMF1uMJaJDFqQC8l06t981EyLiimkxe+fK7joSu6q68q5vDx//WIqIl
         vBt9qr3/k9D/R/ZIkIFGLXaH0HbaYkJvNUB/YaVGquOhFX6ZPHoek9be18kUxZFOhCd5
         cLZg==
X-Forwarded-Encrypted: i=1; AKwUvBy3yptRRUNfzP9MAHSRlKywCJx8o8RGzD7hJHvr4jb8Kw2BliO1yMa5nMvQOEap2fEhKlUh2O6/JPIik4EeaCs=@vger.kernel.org
X-Gm-Message-State: AFuF++n0GFaXQ1iT0zx8l062f95jbhpvw+KW9NXBcRx6RYsGioJslueb
	adrw34guKMY3vYKqRfrGUdgYSFrXDmnZ35WSe6+Oj8RuZtSXQ7H0hvu2vmd1ipo1l4csXv3R+Di
	m
X-Received: from pgei9.prod.google.com ([2002:a05:6a02:5269:b0:cc7:52a8:e3b6])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fcc:b0:3a0:6b20:678e
 with SMTP id 98e67ed59e1d1-3a07e516c46mr1787372a91.13.1790145564662; Tue, 22
 Sep 2026 23:39:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:39:22 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923063922.2693049-1-morbo@google.com>
Subject: [PATCH] HID: core: add __counted_by_ptr to struct hid_parser
From: Bill Wendling <morbo@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

In 'struct hid_parser', the 'collection_stack' pointer field is used
to store a dynamically-allocated array of collection indices. The
size of this allocated array is tracked by 'collection_stack_size'.

Annotate 'collection_stack' with the '__counted_by_ptr' attribute
referencing 'collection_stack_size'. This allows compiler hardening
features (such as KASAN and UBSAN bounds-checking) to detect potential
out-of-bounds accesses to 'collection_stack'.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..403da4cef890 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -790,7 +790,7 @@ struct hid_parser {
 	struct hid_global     global_stack[HID_GLOBAL_STACK_SIZE];
 	unsigned int          global_stack_ptr;
 	struct hid_local      local;
-	unsigned int         *collection_stack;
+	unsigned int         *collection_stack __counted_by_ptr(collection_stack_size);
 	unsigned int          collection_stack_ptr;
 	unsigned int          collection_stack_size;
 	struct hid_device    *device;
-- 
2.55.0.1082.g2b9226bbc0-goog

