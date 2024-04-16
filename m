Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A45D8F6
	for <linux-hardening@vger.kernel.org>; Tue, 16 Apr 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305409; cv=none; b=ld9MbcbOwJZx4+JyvZ73W0jvmDZjew83CTAvdT8npQezvGN5eZqKzXo9yyUgRBvfeiOU86yo6pldkbcnc/W+I5GqoNZ4QSlFV/TvCYtN+w6l3VNUhPXNsGJ5BNHAEbu8t0Smb4+bsTW/9OKO1aPOg7MfEsW7cnPxsmrmL9VGgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305409; c=relaxed/simple;
	bh=WRfn/cAsNNMRbBq4GuWQdlT1whoo5mgh0SJ91YMp45M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMHlB9kKku0bx5dZCbCxmH/rfcL8mjmM2DSnyAGDxW4LvxZS0btXb3m1mU4xhLIKOReAVtdma1nQa9crtego/aZpQ32SLSYk6388EHA5JYL5Bm9jPgHFEWKvPuFxipBbgMXvYj5rT2zU/yCMFTJbKfRoSCfISkGor/cFTTRSwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mZFsERtc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZFsERtc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3023782a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 Apr 2024 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713305406; x=1713910206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWpnbwrols/HFksVXx6/pFTtlVbtQF7yySAM3VjY0NM=;
        b=mZFsERtcoeR+yD6q+ecfyS+3pRFu1IrSUxDCgnESXNVP2gX3duOq02JoBYd6onKPkO
         QCzTDUlGVfwb63i9R7CsdkZqM9YWeTQnyYrKVvFV29f6SbA56cKAk3yKRQzaaY+bjogJ
         jBhp5wjwY3vGVkiE62AQ3mbu5JxPW3bDGs7Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305406; x=1713910206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWpnbwrols/HFksVXx6/pFTtlVbtQF7yySAM3VjY0NM=;
        b=l8uL+axBq7XeW85nXUVujqmvjDkxpQMeq+THFjaNiMQa/y4wzPOKgecrxwmTNs/zwI
         bsgvq1zOM8gmdFiUCyNoYNqMBVq0uOGgk8xoF6JTqVInx2KsCmb9xfEmxhYXR3/uPCPW
         Wzffz3ErAK1OCqoxZ/BgtMAfHLG2tEdZJPgM0HEvZ92AvzqoFUeGh+I01BmhvsthcrCk
         pqX/dSVHf6Y9ra2c1Kq6Lg6C9iGuVAId+/2UZcFeNCEbtR3Q6rCGkiKZChrw8ZIwJQ8a
         1E7X1wIAQhUan8o94JN+krLN0BOD592HnzitK1aYaFFM0mn3TQNsFr2UtxVXiZx4XllR
         xwGA==
X-Forwarded-Encrypted: i=1; AJvYcCU6HgDl7AueIxMA+dlsMAXOEXSkn1mzgyB64SzQIWdzGk5asbEQDB5Gbhoq0vEPD8j2Bzms6nhdA/oCe+/5E4gzfhKDMM4FWQ51VuBYwRe8
X-Gm-Message-State: AOJu0YxE0/9Ub03hZ2ofFqCouxq+NYHx6Sb8DvrTpibgEtLVe3heRBIx
	aq7b6AqOmTtT1vnxdfhGBUfUDUm8Dn5RU9zKHWB6CqPE9o+TRvoZLk08viboEg==
X-Google-Smtp-Source: AGHT+IFXzTOtdhmzkFf7kvRjs/2yOBCu6yaN7ivsHMPoTYcwF1gpR1l+bDIYrHHeInvIb0cUfNNPvg==
X-Received: by 2002:a05:6a20:9f86:b0:1a9:db37:bef3 with SMTP id mm6-20020a056a209f8600b001a9db37bef3mr8840834pzb.12.1713305406053;
        Tue, 16 Apr 2024 15:10:06 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id q4-20020a656244000000b005dc4fc80b21sm8032266pgv.70.2024.04.16.15.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 15:10:05 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/1] selftest mm/mseal: style change
Date: Tue, 16 Apr 2024 22:09:43 +0000
Message-ID: <20240416220944.2481203-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This patch is a follow up to the comments [1] on test code during
mseal discussion. This is style only change to the selftest code, not to
test code logic.

Please apply on top of mseal v10 patch [2]

[1] 
https://lore.kernel.org/all/e1744539-a843-468a-9101-ce7a08669394@collabora.com/

[2]
https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/

Thanks


Jeff Xu (1):
  selftest mm/mseal: style change

 tools/testing/selftests/mm/mseal_test.c | 124 +++++++++++++++++-------
 tools/testing/selftests/mm/seal_elf.c   |   3 -
 2 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog

