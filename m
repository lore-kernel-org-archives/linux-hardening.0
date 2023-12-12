Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TyBjuWlz"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141EAE3
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:17:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d04dba2781so39328815ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423035; x=1703027835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL+BTz2K9JmfgWW40zZKnYHQ0fFwxEyXyS5r4SraM1c=;
        b=TyBjuWlz2QWPbohiHkWTUANQfk4hCqqFjbNhgTsqEpaS3knwjlCsXJVWKWwzvBHIyV
         iew2Ew/6Ai7U/QGnuhP/wf45FSx+1sw8siUl2EpanVEvmZsyDwijfgEO/P33jP7y+b/S
         4g95Imryk63/kRG8ozB3rZyt10UIxvTHCM6ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423035; x=1703027835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL+BTz2K9JmfgWW40zZKnYHQ0fFwxEyXyS5r4SraM1c=;
        b=SvAcr8RGdWmiZEhjttgEot9+ZFKh/4gC3JlZl5J6nsRDcaGQi2diWTAY/DIlpBVVX5
         n2/QEeIgwmGhzP4GrFNbrvBvOvBNZxBb7L+AffCsZWk5pw2SXXsUIZeM2xNa0l4mSRjq
         ccIWoZp8ROFYlXGIFWi+OLmQ0qZ2SaA8oQoulWnmrhwQhEVNq5EkwUnU3emfuH/2d54D
         m8adtIsIJAFYsSA+b9giGuGyzg68hNpNsWJnU6aq6wgcktqWYoJKkmqsTF7DNtwJLl+W
         yNdo/33UbZ7kIWyU9xxtH/EXAGr1Rqd5hZ88fu1jVY+mYELDIbhlhtWUdchnouqM382p
         utow==
X-Gm-Message-State: AOJu0YwJTTmqbsO6C2IQ9qvZ4JT2gJpu/r1JGBLWvX1GltevUxvcojeQ
	N1g3K1ow9N2Em5Z2993PxSkWpw==
X-Google-Smtp-Source: AGHT+IGFBfEL94OuzDJXPeAX8v2gc5zss9OFnE/JNle1zzc7v4J2psWLGmJv7VyTMrs5itl5BiG+DQ==
X-Received: by 2002:a17:902:b702:b0:1d0:7d83:fdd9 with SMTP id d2-20020a170902b70200b001d07d83fdd9mr3543832pls.122.1702423035559;
        Tue, 12 Dec 2023 15:17:15 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id h2-20020a170902f54200b001cfc67d46efsm9074320plf.191.2023.12.12.15.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:15 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 05/11] mseal: add MM_SEAL_PROT_PKEY
Date: Tue, 12 Dec 2023 23:16:59 +0000
Message-ID: <20231212231706.2680890-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal PROT and PKEY of the address range, in other words, mprotect()
and pkey_mprotect() will be denied if the memory is sealed with
MM_SEAL_PROT_PKEY.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mprotect.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..1527188b1e92 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -32,6 +32,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
+#include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -753,6 +754,15 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	/*
+	 * checking if PROT and PKEY is sealed.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (!can_modify_mm(current->mm, start, end, MM_SEAL_PROT_PKEY)) {
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.43.0.472.g3155946c3a-goog

