Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788C171066
	for <linux-hardening@vger.kernel.org>; Sat, 21 Sep 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726940549; cv=none; b=FvOnZfYsVlnvVG6CAjMEq7c2Li+au1WhdlcB00LNKDRdoqoBPhcdwOPoFITZzcs0Jnge6Kgz4eDTVUfI7CEEsTskpLNJVr9knHq+tfU5BILyQFylLMkDk3MPV5mVyJr9QkTwcXos58wfo5AbJijcKn9mBc9lMc2FoUc1D60kT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726940549; c=relaxed/simple;
	bh=JgrYoAupbc8OvNFMx54RNgfQybMF51dGHAZ6mKbefj0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nWnFkvlmqAdedmk8galrW2eJmFg6mb1xkiSgDuAOicqizJNZNnV1Qq5AUKqQLbDNwyzQ2CHVpRCtp1RQbWnKGJULyt5vBPpmj2n3lp63OWtFCBqKbsFNP1IaOQtPfySK1Qq0vRCDwJuuPNvf8CeXAx+P9rCCKHmP/Uu3MZojjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va2EzS7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va2EzS7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726940547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JgrYoAupbc8OvNFMx54RNgfQybMF51dGHAZ6mKbefj0=;
	b=Va2EzS7n1ckkVNjjUSo34Es65gK5HMeBPLs/IqTAThW6/hZ4wSZTQdaJ3tE3oPo6OB+4BO
	nxwFCgJEUoZMLiY/4Asq+5lozMTfxn5KPlK5LbwB4k4n1DQ9SGjZL9rXwkNxcMjg/qMnpT
	5enN1P+NHYRL3BtZngvlWk6dUpTCwlg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-7Sb7R7E8O7mbb-zQ2EGS4Q-1; Sat, 21 Sep 2024 13:42:25 -0400
X-MC-Unique: 7Sb7R7E8O7mbb-zQ2EGS4Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2db5d285f7cso3068813a91.1
        for <linux-hardening@vger.kernel.org>; Sat, 21 Sep 2024 10:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726940543; x=1727545343;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgrYoAupbc8OvNFMx54RNgfQybMF51dGHAZ6mKbefj0=;
        b=BP+nJALk9z7Nc6AYIszL4M+AIEnWNSKsLsLXh66O3b/uNwNsX4zZtj7qQyViauw2Ht
         0dLBxMDK2oOqi/r3pJRZU3FWtidVWTBDcPDRHI8UKno7HTQDxtp9o/1Ru/yzkogf64lV
         ETue8ZiVZkrqK+h+5dC0dSpMCZcUHK3FcOoPytUV/icpsIVWIG4SS0Iaa4o4jpy7c2gh
         uRrVDCgKITmdSvfQHKH1A5McR+2qygTek4KG212kQaNn7sDZVcd9CUU3sWl3C5GK6zp2
         VRMYUOv2IIe/RDiWiawUT2NgCR980Xe8jNWsl5MoA2JTQICYpRzeOZ6Wpr3eJbUhwpPr
         LLUg==
X-Gm-Message-State: AOJu0YzOG6YILOpfP4Io7zKoFtvTZweO1QAIKb6blu0O4WTvDJw/6d0/
	C60rSJY6RwS7rWonqUpNvTDpY76HM9cjlWPwIUuqphQe64j9cBIE1ddwW9SvQ+XLU0dg5Ef1DXp
	EHZvT4d2dKiz6woE7zz8F9saRTLKkY7/8MQnTt/xfILlFVrSGWM7tPdp05NREnyt1HOh68reTQB
	zBEUshzDX20hwy6e8JTmXIdpPUTuXC+gRsnyvBzJ3IMz10k0Jqgh8=
X-Received: by 2002:a17:902:e54b:b0:202:13ca:d73e with SMTP id d9443c01a7336-208d83b93fbmr96970215ad.28.1726940543362;
        Sat, 21 Sep 2024 10:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwKUefUGhW4P9+SPQMWxP6OdoTY4qumCwbgll/jbfjtlKNhI1zFL0C4CRiW+QJV0IQYuCYE57e7UXcnCMnUK8=
X-Received: by 2002:a17:902:e54b:b0:202:13ca:d73e with SMTP id
 d9443c01a7336-208d83b93fbmr96970035ad.28.1726940543063; Sat, 21 Sep 2024
 10:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Montleon <jmontleo@redhat.com>
Date: Sat, 21 Sep 2024 13:42:11 -0400
Message-ID: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
Subject: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with FORTIFY_SOURCE enabled
To: linux-hardening@vger.kernel.org
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, kees@kernel.org, 
	linux-riscv@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Starting with 6.11-rc1 I can no longer boot the Lichee Pi 4A with
FORTIFY_SOURCE enabled. This works on 6.10 up to at least 6.10.11.
However, with 6.11 I get no output at all from the kernel on the
serial console with FORTIFY_SOURCE enabled and the system never comes
online on network or otherwise as far as I can tell.

I did a bisect which led to:
2003e483a81cc235e29f77da3f6b256cb4b348e7
fortify: Do not special-case 0-sized destinations

If I revert this commit I can once again boot the Lichee Pi 4A with
FORTIFY_SOURCE enabled.

Thank you,
Jason Montleon

