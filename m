Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77650E59E
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750968; cv=none; b=r5mX5eBqRDmpq11S6Jr8skgkjZi1Fr91NXVgtrmK/aqhSIQQgI1G8EY3E6i+No9tZqsXXTLPXjtvIEjwADwYMS67dXe0M/jBMdsc9Nua7rdhMkVXRgZvXsLuPRx2K3Gtx+nG/Q+6Fczwyp2l5IFeBOhc0CmTTS9cwLbxxVsm/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750968; c=relaxed/simple;
	bh=bDpGvspOu4nFgSreC2Aw9attytrT9KqmqH3NWl0cZ7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vtz3Sbfz1P0dbMV+2c7DFvilm0bS7W8JWF54uCjK/ZVUXmLy/cOIyS1BDdaPcH3r8DXYtMojn/kpTdDjVaomkC7D3KC24ynFdCugPVU4I4NXeUeGHCYf5N+19iD1yMLGDQsf4O/qNYzlGq74mwkUkgIfv+LzM3MTTz4dAG2Ae+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOGp/X5O; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOGp/X5O"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd8920c132so21059895ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789750966; x=1790355766; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSaA4/uDxQE6ypmPHF+DraAaXm7U/OoqsySVnlQHd24=;
        b=gOGp/X5OCAeXmkvZ6r/Rs8YgHIjxwsD4iWl8xR6EtKhO+1n4tmQvRRh0oN/g1vaJFu
         nRFnfmsKiwTaDwsW9ABmVAFhLI62xiMEqch1O0weqCakyYiHZmAujXnJ8XB4/0yelwsB
         jiews6SI5vLdvuetGbilTiBz5P1vMAKLxeZQxPOIYz9Kt7L+4ep1QM9Z8dr6QMwqg4E1
         FNjGrx/goyoZggC21S6a/or1wwh22RrZqZNByU7MV/Sna5n64S+9/zE+dNaRlFPS4sQ/
         ZFAtE9e52SoSEnxFZnoicfy8e0rIJGjpXBJx8qeSdbZZbGuyGqkXQk6vU1Om/k1s/ewp
         1leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750966; x=1790355766;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSaA4/uDxQE6ypmPHF+DraAaXm7U/OoqsySVnlQHd24=;
        b=VhGYwAwdY4eqdB9hIfJyjPRSCEiEgFTjwLC+dZM4WAkJv8h7Z3zk6wuNDMpvb40uO+
         P9FE2ESK2NEPE7tHZAEclA7GCE26ReuPOnEQOwxZKU3MNy/K4sqSo8n/q1HVY1Ql1Fvs
         QRE/MmJeS9RziqAo2ut4AvFc5E9g/LsevWTe791EZPye6oromtXpfv6KP3rja2N1V9kf
         VqpZfbe+Wvd+0eMZKRfS4QeTPorBuqUdy6/uUuU6KwE/+zZEfstaY/biqTSbCoXInnkA
         lG/Sad0xYkd8jquimrOTi2bADZbamTM8ENc/QxcoK7kUaU8oN/VYoPbPpGomckLuwjJg
         6wQg==
X-Forwarded-Encrypted: i=1; AKwUvBzuZma8R57u8JMjS5JKxJx8A9uI2qBGdCWAgAu/G21stwX2sKTF5H+CBlnaSUBoJ1H/NPKS7Sy3y8xaJu7I6Cc=@vger.kernel.org
X-Gm-Message-State: AFuF++m3e9N+KlQbTz0o/t04ZtPfY2GvMj6G/CJnUz2KmE9HwDT8w30N
	gpWzB84OrDKSW12JFdsEd6YgPksa5AsMxEUQUmDGecBD6W/lu8EwW2yxLoIoMaaQPoWdhg3sWO9
	dbkG12dMLBqSJ+TM8EhEinjvCOiUB12YZFg==
X-Received: from plld8.prod.google.com ([2002:a17:902:7288:b0:2db:60a3:afae])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2388:b0:2dd:ad74:ac1d with SMTP id d9443c01a7336-2ddb1bb0740mr74481335ad.24.1789750965612;
 Fri, 18 Sep 2026 10:02:45 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:02:44 +0000
In-Reply-To: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918170244.75711-1-rathodpriyank@google.com>
Subject: Re: [PATCH v3 0/3] PCI/pcie: Add PCIe Lane Margining at Receiver
 (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Hi Bjorn, Ilpo,

Gentle ping on this series - it has been two weeks since v3 was posted
and I haven't seen any feedback yet.

v3 restructured the original monolithic LMR driver (v7) into the 3-patch
stack Ilpo suggested during the v7 review, moving the link endpoint
traversal into the PCI core rather than duplicating it in the feature
driver:

  1/3 PCI: Add pcie_get_link_endpoints() helper
  2/3 PCI/ASPM: Add pci_aspm_inhibit() helper for temporary link state
      suppression
  3/3 PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

The LMR driver itself is now strictly self-contained in
drivers/pci/pcie/margin.c, with no modifications to drivers/pci/pci.c,
drivers/pci/pci-driver.c or drivers/pci/pci.h. The series builds clean
with W=1 and is checkpatch clean on x86_64 and arm64.

Feedback on patches 1 and 2 would be especially useful, since they are
the core helpers patch 3 builds on. I'm happy to respin if the split
isn't what you had in mind, or to rebase onto a newer base if that helps
review.

Thanks,
Priyank
