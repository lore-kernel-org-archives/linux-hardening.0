Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4738DC71
	for <linux-hardening@vger.kernel.org>; Wed,  9 Sep 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975449; cv=none; b=dxCMAGhMKeUmtX4996iH7c+Og5XDiPD7mW2/NWbx9d/YMJepUZI/h1k36VYNu8BNHCR9dY5pfwOs4t7yk2XIulrXOD5JN8QSusy/iuGcy90mTzIa0F4HtS+w3QCrMCnIhL4PuKYorasiCK62MC1oppgQmQj0gKU/HwN5sRfTS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975449; c=relaxed/simple;
	bh=gllQAeSfz8wD6OjJWJ5fccK3rEpdJJl3i7TSr7C1Q/s=;
	h=MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:From:
	 To:Cc:Content-Type; b=VBjm7Y9hT8DO+WkExgojFSvm0n7k4awlEscIYiUrCq7R2jrkZbpYsdn7aosWN1ywWrLupHUNFnPXg2G/MvzlmRRSVfLCagmsFo7K53HkHBdq7JEgJvNlgdvLrFnJyBAF7RJs/9su9dLYksKrpxVetMWALlfSGb8PhOZBtFu810g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvuO/HSK; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvuO/HSK"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-385d2703b64so84262a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 09 Sep 2026 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788975447; x=1789580247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gllQAeSfz8wD6OjJWJ5fccK3rEpdJJl3i7TSr7C1Q/s=;
        b=gvuO/HSK/9iYthsXgB5bsFybkF6WCELlRFvN6jycMcN3Fzj24u00/ioZ36PivkUnmF
         YqeZWV3FhohwZle0aIxlcdJvY7Qddu0t7uXPM+FVbPUs6c/k1InnWz0YOug5LJh8VQn2
         Rsuuj8tWfVCzZmuQ/WqW5INOiplmvrTshXEVHrxkCk1cNplAxtsEmWTFbHA/dL/llN8q
         xWy5GgYU2qr4HtR9SkqmHGB4Ci+PqgnvMbvp1FcsZDbMfRIMEADD0LbuvY3ceAp+NPXF
         7zF16NTnAOX0SbUlBUAcWrbmqGN3uXCkJu6/Kg6hGIfq0EgJcja1gwoAKzkqDCIu8/lP
         AIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975447; x=1789580247;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gllQAeSfz8wD6OjJWJ5fccK3rEpdJJl3i7TSr7C1Q/s=;
        b=EroWu7wAat3K9lhqwJ0tf7LFpdSsdDq/U5/LY4fZ2c4l6nOnyr8uer8lnGLT94eUbR
         whc6RMJX1ZdOj0Gj/mXgH1rV5i/aCdoJbu1OjoPMirbk+yzYsI7f5HxAk+tlfz9J6fIA
         pASGjELC5mbN4CoR2BIW8yI/x2KK+ij2NknDlHsvc0+fYP0AvjOu59tz7hcPU7u/zpAc
         JESIdGTrmAqHJgFsQMgBvP37MQCEfU8Nhp82mAzP1putrNkDxjDGuRGng8i5we9dfPsT
         DlEbjYUL5Hkmfsv0i3vUn85LknqsI1QS6peTCfdZIDrQOfCs4X1s5XtxNm3t4SwfEMK6
         i2kg==
X-Forwarded-Encrypted: i=1; AKwUvBw0N9+FWOaeV3t1Fj2RVQipfX18TimuO7U9p3tgfcztKSGyLTE0hZXzA7DTjct219r//jyiMg4St9hk14Qmif0=@vger.kernel.org
X-Gm-Message-State: AFuF++kesY/fQ+RDLGXqLyXt987t/5jc065pAE5BGRkin3FEjxUwRoCU
	DWVzchKlAUfSqVoo3RX+WWLJy0d1rRVjDZxnw8utZW7aQJBoqkenl1mSpMhUWIQnBaI+BFUCfPY
	fO+lsxuJR3EB/Cz3f8VVjJUCyLN+YL6TdzA==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: from pjbpm12.prod.google.com ([2002:a17:90b:3c4c:b0:396:702b:655e])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:37cf:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-39d77aa1851mr284135a91.8.1788975447027;
 Wed, 09 Sep 2026 10:37:27 -0700 (PDT)
In-Reply-To: <202608260405.gHL6gOJf-lkp@intel.com>
References: <20260824-pcie-lmt-v6-1-bab4ce233fa5@google.com> <202608260405.gHL6gOJf-lkp@intel.com>
Message-ID: <18d3b7b0cfb6fcb1.3137322e31392e39302e313337.965f0.0000sendgmr@google.com>
Date: Wed, 09 Sep 2026 17:37:27 +0000
Subject: Re: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	lkp@intel.com, oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

Thanks for the report!

This series has since been decomposed and restructured into a 3-patch stack,
and this issue was already resolved in the v3 submission:
https://lore.kernel.org/r/20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com

Thanks,
Priyank
