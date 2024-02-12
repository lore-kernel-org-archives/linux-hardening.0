Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4A3A1A3
	for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742899; cv=none; b=EQg/S62+l4/z0f45n5Q/hGM/SBo0SACjc+AaV00XkZkhwox69GP4yslb8olREhYpTxnGUlhyC9uGxhKmMdjCM6pMXm1e5BiTs0iW+ZlIE+f3UAzKOtOtL3TfaGnpHpRvyoW+yLuhfG1PeFgc7KKyqgG8CdAxAHaxHCJCGXzLXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742899; c=relaxed/simple;
	bh=OEgOfFbBWtYOo4zoZjGOmPqaBaNBxeMwq2pAbEbCgeA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZUvI1Kr+fQuwnKykBBYnKw2BgONPbvKoiB4spCunMVDABxWLcfQYTaFFNc7nVSTM13SfXf01MlRdbcb2NKIFPRzunE14tf8cxWR2iClg9PdpYLrLIeHH39U8XRmX8QeRSQUtWPck+PFlIiiluQNjEwc3ozFdoa6zWgb0+YoAC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HG/13fVu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG/13fVu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc75b9611d8so3298809276.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707742897; x=1708347697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pdujWWnO8d2IohPiw763CkbnCFmrIW28np/fZXta7cg=;
        b=HG/13fVuF9jR74rWV+ReW4NcEyZvAtID0zs9CUmZPgAuR6gMHKLlUDOCbLWEjRg5ql
         IgG8hdXSUwGL1Lc9qSlVcXbLlYY4dF/HGDWf9k+0yC78lwg7V6DOM24lsXe9ifnVtnM7
         4Rnb3McrVDYj8Ptu8BMvKLKqBRZhfwpICYOjFi2E2yMicqW1Yh4q2h73ratj2n7Zrrio
         QgNzaixTAFCHN80wTP/3G+RHofIKbM4un+104l12CL5OnSMl2kjwlXSvc6YSglBqkgVd
         Pk4Gavf/50Hk9qPRlxaGZWXkGgrz6lKz76PctYCvL0aFusejQOeQ1mDUudk4ox7iCCiv
         su6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707742897; x=1708347697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdujWWnO8d2IohPiw763CkbnCFmrIW28np/fZXta7cg=;
        b=mGU24hOi+CbogCMImkCO3ADFeSn42dqH8Gl9xgzuquTHeRykurzU3GEAOKeTHQypwQ
         m+9kER4kJbpXNzr576yVYcSmvyiMpgDzoOE3TVBwcTpn3hIXS/upCpPW07eY/p8imYBH
         laAL2AEKgrR+SPWibL8ITe3AnbmAXDmlRLHA2Tro6YzdVuDtfjG2v6oFeYK9yfUXnpUR
         H6al7VTXFLfmBNpB1oEVIsz5Gqh8EsdoOjnru9wzu48dtH2tsD+jf3YGT1SjOnwW0GN5
         tp4OhpVFJXRATWAb1Mr6J1Utug/WdO7hzegnICaSPVahrRFTz4xaZcNY9CebCjfxcpPj
         /Llw==
X-Forwarded-Encrypted: i=1; AJvYcCWHifpqEmUB7F6SOQ3h3QRPg93+z8+9frOS7Az9/0gIiopRDwDwy7vWlmwLrFqHfcZY1UP/usBT24gZ0jS0fsYxVTLqM2Ka7CLcbr368Nut
X-Gm-Message-State: AOJu0Yz5j/CRustFuXrYr18w73QxBUa+t+fQTbXyuiFBs76XQGJUWg5Z
	aFJkgGc4bkX4uX1cOnvHCIuw2/j14t+vLpms/90zzl6aCMbo346eSQfR7kv0VgecBJAXMvFqCA=
	=
X-Google-Smtp-Source: AGHT+IHYW5UG9oX+HgucYE1vnEAn3ElMO2Bfe6CkqTfCKXg6CbgSRaRP8kEIytUkLEyn4AtvAwJnUriFyg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:d6c8:d450:ebb5:bf7b])
 (user=elver job=sendgmr) by 2002:a05:6902:188e:b0:dc6:b768:2994 with SMTP id
 cj14-20020a056902188e00b00dc6b7682994mr196715ybb.0.1707742897343; Mon, 12 Feb
 2024 05:01:37 -0800 (PST)
Date: Mon, 12 Feb 2024 14:01:09 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212130116.997627-1-elver@google.com>
Subject: [PATCH] hardening: Enable KFENCE in the hardening config
From: Marco Elver <elver@google.com>
To: elver@google.com, Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

KFENCE is not a security mitigation mechanism (due to sampling), but has
the performance characteristics of unintrusive hardening techniques.
When used at scale, however, it improves overall security by allowing
kernel developers to detect heap memory-safety bugs cheaply.

Link: https://lkml.kernel.org/r/79B9A832-B3DE-4229-9D87-748B2CFB7D12@kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/configs/hardening.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 95a400f042b1..79c865bfb116 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -46,6 +46,9 @@ CONFIG_UBSAN_BOUNDS=y
 # CONFIG_UBSAN_ALIGNMENT
 CONFIG_UBSAN_SANITIZE_ALL=y
 
+# Sampling-based heap out-of-bounds and use-after-free detection.
+CONFIG_KFENCE=y
+
 # Linked list integrity checking.
 CONFIG_LIST_HARDENED=y
 
-- 
2.43.0.687.g38aa6559b0-goog

