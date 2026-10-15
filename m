Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008F3C7685
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041730; cv=pass; b=G94Vsjc3kpiDEwEW55SIe/sz8nFGqM+SZUInjz0LQmlJS9pBu0rJT/Y6+MLuK4dUDMwvRzqIFUEdyHolYNPKwY0RIkNJb4r9tB2Xe7eIBTX3/yXzd8DxGtBQw51ETc5SN1NKYoYCuiVPUgGuL+VtByRjZPareEykdCzW3Tf4ADs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041730; c=relaxed/simple;
	bh=LCA5ygrhxhhkIA05plaRNBxJfo5PazKMU7keUhXUWVQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPK05CYcjOrTCg7NkPqNzUfipg31IQ/xuAtS4IHOSp7aK56SlxAb9vWnwvAQRkmi81kxl0+mY8ywv3E83l5oBNFEvIgu6+8AxEGgqgT8AG2EV9WFxd0YxL9Dw/KbNfWtf2yMX2eEFaJtJ9bnQ41tXNfAW9fzBatIsScv/w7yY7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=AgD0ODUC reason="key not found in DNS"; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="AgD0ODUC"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-823b938464fso1136238a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 22:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792041728; cv=none;
        d=google.com; s=arc-20260327;
        b=mhV01MXQx7NBCpr/cnc1DrJtMaL2SaGmv+tIrtPiAdWI4FTlGBxVSnaWUqT37E64DL
         uiR29ITtAAHiX7cEM6LJOuDV0zJ3AVe8HwBH9Iuh8qD9WS4vgpF1H20DiKbxcdv6MXGq
         3ojguWqJ50fKb+Y4QGMvE9F7EPuX/pDVqQGbD11o+0AwoZAoa5zoVBRNRCIDy2TRCmzq
         PXO/nydZ5t+xDAg2u9hqTwTV/PCa7A003GuM8wjWAQ23/zPivE3L3B7Af2Jxj4yfhTYf
         MwZrbb+VVt6zH0MwqwjC3MJyWq0powrg7uMcvSvPg5XXF9HRn8Lc3HAKDwn2fpdto8OG
         wtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LCA5ygrhxhhkIA05plaRNBxJfo5PazKMU7keUhXUWVQ=;
        fh=vJZrdUFZf5WZBZqwUxzFLiW15wfNeApKe8qHczKh2Og=;
        b=Dg/Esk2/2qmJepyxIo61fW8otlQIFuU3rcwhLpy3rU5p450K0Bh0wiFxw/c1aSG7bQ
         ClMmXYdzShDIfQ7WXQsb8owdyemjWjgsqfOe34R0QdhQ5xCO9HmKWNnxEEhnBrHobPXO
         cJets8lMSKd1Xwb/MICFZrm1kdMkH8gmWjh/EaE54cJKjISLasPlehtnqrnRktkQXuR2
         SYGr98wO1HsQQ9WjoyXgnork35P0Dj5ZZVoZT6TVfb3GfYTPrhPKTNVuga6+YA11Djt0
         uVHqGZ5moCYXO6QMVpDosIGwLRI6R76c6rIdSTk9xnfR+8k97whpzhUH7k5atR/9S4ot
         lkqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792041728; x=1792646528; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCA5ygrhxhhkIA05plaRNBxJfo5PazKMU7keUhXUWVQ=;
        b=AgD0ODUClZW46Cgwt9+DDfkEeVu66OdbfsP4U6ib6YAn8jyX5x1u8yKqQg620Vy8AI
         h3PZZKAddnwGDsWQ0pIS4jkr7y40oKykDK2wpR0g5u0s3gXqIxmd+SddxgxUP2dq6Wec
         043jCUd7rrREoInBlP5nzXfP1k0/7yAZ84eE22dKuDjRCtzHgCFvF4kC1ZcoyBfnGszR
         nU8/B74my+KsIxhbOie2kzwCV0YKslyw7ShE+WvIHgHJ/kN7vG3o6nFqMZX4952PfUdu
         dwD5gJZUNM9SKv5S75yRcEgDE8LnLDUk+M3erz6IxLCqu0GQHpMJy6piZchVAHBK2Yu+
         84nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041728; x=1792646528;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LCA5ygrhxhhkIA05plaRNBxJfo5PazKMU7keUhXUWVQ=;
        b=eC+cbzivIDyphjWDpUtWProrlfdcRWX35OnjcQH04b1xVpqDjyQUBM9MH59nKZMkZm
         sOCLvbtVkG1Ay84qs8MVX8103Kb1E4Uk60o+zj49tl7XgXi7ArFFfBX3UmkySxvaoYWk
         vdrxPa/AC8hhsPSqLtbqKnkRuj1l3bspxe4mrg3n6WnwDDyRgvIC8BoC2VGIW1R5Ksc0
         mJahAK6/6MIchM/1dmGYfz6O+SfnzSYTGukjoawN1h5g4hm9x6rSeKcWEOHC4axXfEIM
         9LzoQIpA7ij5Jo8C7o2PDv2lTZvSdqYWNYBId9BA6gjaNld7PVNGcqNRcpAASx/TeAur
         0r8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwafk7dRjsyG0A54LUqI7tHd7YjdFNPaUCSC5e7/AA4iph0FROgnjvq3NbUQciHIL81LDSJrv3a98RALlgqWkM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJxoS0IFMXDxHkz+CUsjCMm1FMBs1eiAjhwaOjx1OWVa1J3hIu
	PMlV7GbWfkmTjgh3wqlJFC6/PuQSxUwFWUq1STU2KCXTLQS5wc1EEowoQn+1HDvoYqoKRYN9E/g
	ZdEUnQKExVWFDvB/etz/odEpOe3Ca8lV9th/rKLKkww==
X-Gm-Gg: AYBFou2nHLJ1ctTDVcTOLM+OrgDNS9dY3X4WTeV8d7OOymU0h9749QgGIj8zznyItsw
	oBu3lqADlinJMF3OiN0AvjGIaSqQMD3eJDIF5FO8mw97GIVfOys5xM/w9YkNws0Bfd3vvyNxn2H
	TaYQPe7lQ9hzBzDjunsroliH+jfW+OKhYplIy+UwdLos3vHw4Y0xNbo8sFLv9/V8zWwrub/KKuS
	PiYumFrsEu29hR6gqRPbrPLW4YTJhTb1pTg3zCNbKEnmXAl5sWbgjM/Mq+D/wjyNYewSKu0UmPv
	EwZ/RTHo/5rPGOYVMwCC1O0L/AcWI/383bGj0TvtOHCaDFbcNC6r/98Zn4sE6MvryCak/n18VfL
	ohm6HGDfh1YnO1itNugTZY/4=
X-Received: by 2002:a05:6808:50a3:b0:4e6:a21a:8c38 with SMTP id
 5614622812f47-50c53c90338mr16422275b6e.39.1792041727716; Wed, 14 Oct 2026
 22:22:07 -0700 (PDT)
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 22:22:07 -0700
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 22:22:07 -0700
From: Iurii Trukhin <yuri@trukhin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <x4iu6sii7fsxksdfur3wcpu4kb63eubsp5d6pzklxuhta7xtj7@rskyoy7ajncj>
References: <CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com>
 <x4iu6sii7fsxksdfur3wcpu4kb63eubsp5d6pzklxuhta7xtj7@rskyoy7ajncj>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 22:22:07 -0700
X-Gm-Features: AclHuK_bFzbfGIRxfiHxQRAWNh28jgXvMZCZ8XCr7vR2oiT7mhNNzw5OJD91xM8
Message-ID: <CAOx7e9LcNFVS8K4bBngeYEpJTXFwADA+xgw6f8r6Lh2ms-3u=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and
 52-bit VA
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Iurii Trukhin <yuri@trukhin.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 15, 2026 at 10:25:49AM +0530, Anshuman Khandual wrote:
> ARCH_MMAP_RND_BITS_MIN still gets used when VA_BITS != 48 or 52. But this seems
> like a subtle detail. Just wondering - should a comment explaining this default
> random bits fallback sequence be added here as well ?

Agreed, since arch/Kconfig includes arch/$(SRCARCH)/Kconfig before
defining the generic config ARCH_MMAP_RND_BITS entry, the fallback to
default ARCH_MMAP_RND_BITS_MIN in arch/Kconfig is not obvious when
reading arch/arm64/Kconfig on its own.

I will send a v2 adding a comment right above config ARCH_MMAP_RND_BITS
to make that fallback sequence explicit.

Thanks,
Iurii
