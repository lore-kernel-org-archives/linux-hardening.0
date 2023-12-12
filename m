Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6wsIoUG"
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8CD2
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:17:14 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso5312356a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423034; x=1703027834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgg0J3qxY24SnHD9sqtPXJJls+X5lh0PMbmZ3jrDVoQ=;
        b=T6wsIoUGX3fIwDf01FpNscoSVu4ubDm1E9zTDGFrSasB/SBA+rC/I52alm6lkdDh7m
         PqA/teR0nmJ7Hdgl+e/ylfl9d3bs1oKwrnNortNZZ67G6sZrRO+zazp3yadNcdjwxQtP
         BJ5VJ7ZYbEzS/lulvk5t77B4RRA68VnFkTfWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423034; x=1703027834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vgg0J3qxY24SnHD9sqtPXJJls+X5lh0PMbmZ3jrDVoQ=;
        b=NNEBsav+fQZ3gOWYaxRF3OflkD9eiJuNbwmHZ1HxudMxzWXHLy4kSDOH3iNwa+8EuK
         MD8TNg+WWCyfB10dGkaaOpmzUY3boj35/Sff/UJlXtMCD2wsseVwlEqsaHwnk9TADNPm
         lilGjxBvWn2ps8z0CPI1zaxGwAiuahVMAaKVOjgWl+/OMy4/k/sZpPDWR5HUYkeMobHu
         sOx5OtfzhqbtigfzH14vFRVfuZtgdFBcV4lfJIdi9MmVFMYcy+TiIFVariAvoxH8OMdF
         OFAJXT2GEeLDqSaWHu//BHetaZ2ZIsK2co1nXAJCImYWJDW563PKOlFEY5HfV8G3dypD
         hD6Q==
X-Gm-Message-State: AOJu0YzdXkJ8iGgAZBjLAkqD+HxiWFvGjQaQ5Y98GBrGb/yiuogDU35x
	pMViS3L8LwboAWMDPJu1J8lQog==
X-Google-Smtp-Source: AGHT+IH0w5ya9vjJqVfLSwVuEpvbnpor4YM2jb0u3s8vpT0Fs9e2ntlip5J/9UPEmwW3uq6XLY2yzA==
X-Received: by 2002:a05:6a20:429a:b0:190:50ec:e2e4 with SMTP id o26-20020a056a20429a00b0019050ece2e4mr9563392pzj.45.1702423033741;
        Tue, 12 Dec 2023 15:17:13 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id b4-20020aa78704000000b006ce41b1ba8csm8575780pfo.131.2023.12.12.15.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:13 -0800 (PST)
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
Subject: [RFC PATCH v3 03/11] mseal: add can_modify_mm and can_modify_vma
Date: Tue, 12 Dec 2023 23:16:57 +0000
Message-ID: <20231212231706.2680890-4-jeffxu@chromium.org>
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

Two utilities to be used later.

can_modify_mm:
 checks sealing flags for given memory range.

can_modify_vma:
  checks sealing flags for given vma.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h | 18 ++++++++++++++++++
 mm/mseal.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3d1120570de5..2435acc1f44f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3339,6 +3339,12 @@ static inline unsigned long vma_seals(struct vm_area_struct *vma)
 	return (vma->vm_seals & MM_SEAL_ALL);
 }
 
+extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, unsigned long checkSeals);
+
+extern bool can_modify_vma(struct vm_area_struct *vma,
+		unsigned long checkSeals);
+
 #else
 static inline bool check_vma_seals_mergeable(unsigned long vm_seals1)
 {
@@ -3349,6 +3355,18 @@ static inline unsigned long vma_seals(struct vm_area_struct *vma)
 {
 	return 0;
 }
+
+static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, unsigned long checkSeals)
+{
+	return true;
+}
+
+static inline bool can_modify_vma(struct vm_area_struct *vma,
+		unsigned long checkSeals)
+{
+	return true;
+}
 #endif
 
 /* These take the mm semaphore themselves */
diff --git a/mm/mseal.c b/mm/mseal.c
index 13bbe9ef5883..d12aa628ebdc 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -26,6 +26,44 @@ static bool can_do_mseal(unsigned long types, unsigned long flags)
 	return true;
 }
 
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+bool can_modify_vma(struct vm_area_struct *vma,
+		    unsigned long checkSeals)
+{
+	if (checkSeals & vma_seals(vma))
+		return false;
+
+	return true;
+}
+
+/*
+ * Check if the vmas of a memory range are allowed to be modified.
+ * the memory ranger can have a gap (unallocated memory).
+ * return true, if it is allowed.
+ */
+bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end,
+		   unsigned long checkSeals)
+{
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, start);
+
+	if (!checkSeals)
+		return true;
+
+	/* going through each vma to check. */
+	for_each_vma_range(vmi, vma, end) {
+		if (!can_modify_vma(vma, checkSeals))
+			return false;
+	}
+
+	/* Allow by default. */
+	return true;
+}
+
 /*
  * Check if a seal type can be added to VMA.
  */
-- 
2.43.0.472.g3155946c3a-goog

