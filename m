Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7D39AD3A
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783693; cv=none; b=HABR1y8TDtcvjjvq2bbUtFG0Yw2tX0ZeaPXFt9cs6tVb6K8YlI7JQoZMWIFxUfRY+BWp/Zsl9SJpxHYwnDlnQMcCEAFzOM54woIjTTO6TT0NTwk6zkadHHXJeiswStoGSy7o6pBRyL7Lj/iTR78wWLnUCxf4kgj6NCEVdjYf9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783693; c=relaxed/simple;
	bh=JpwncGscV+/yJCtWhTqMjbxBNZe/rTh+V5vycEaL3AI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mskSyxzcxWcmgYIR85zF+Q6yODXFqcdzdGLCFyms9GKYpX/rosHtPUGHLJKKZ7Ilkhf7ihBgcDJ00RP1JTsiycwU40LmgbCr+iyshnD7D7TCSYztbjoN/QxFICjPO5FYCfWw3Rw0rTAClhTzAIGx6vt3f4mlhZmH2GVlDtC110E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIHfxS5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIHfxS5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781783691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87sV1KJdzQRdpcATxiJd4dyqW0NfL5oL/U+Vih8k7+k=;
	b=WIHfxS5lvKEy8493YBgZdPCmhbOb+S02gDGu+tgJcv/SNkfFXMKpgKqpHEDId7ipNg4ymD
	nMVNQ7qLOJwiB7x8xfO0zPpxUdzJXM/T5WJ4WukbeRFFfEQSLwxIUhfnRlZOai3B2HQKMd
	fv6qm8KlGveGsTnEZUfC7G/mlrrLiHA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-svL4jqegMPiGeHtqDx_rFg-1; Thu, 18 Jun 2026 07:54:50 -0400
X-MC-Unique: svL4jqegMPiGeHtqDx_rFg-1
X-Mimecast-MFC-AGG-ID: svL4jqegMPiGeHtqDx_rFg_1781783689
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so4680805e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 04:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783688; x=1782388488;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87sV1KJdzQRdpcATxiJd4dyqW0NfL5oL/U+Vih8k7+k=;
        b=MTunWEvqZSQxdV1TNy1iYvF6C63MTG5Ky70ybGkXfOZbCH/k4uGs45vxUz5lMUL1K9
         L6WjYyYtW2b07ec1O/EK3n5Kbfl/v2tjIGD2yIkaUUN7FqZec7zA3Y4HGUiaejIrQ98Z
         Dxrk94yQo/YwoHIJ8Z4D/jLfufMnEUy+j4zINFA9McIlS7r6cGrzV47uLvd8Humm6o57
         j8KA4hdmmyy/bW4g+5eBbZyqQVnUlm3yekJYLfMfcLj3+lZzw5tgrrj4KcckdipSXsmh
         LBiNZCF5CQu8cQC+w0qfqqBMD8yxN10YqJ85mMLRJCk8ok6Lw/2sMHemwEfCy4nShtE1
         diHA==
X-Forwarded-Encrypted: i=1; AFNElJ+JFTDVUFzGE2qwc5RHR6jOcQO890YF1YxGF5jQrc8y9mNeTaJKCpEFjSO0Q769lpPnUeNqJEP4K9/betd+Vm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3H9WUjAci4z0xvZzfDPsFlAmcNkEJRxebO6aLhscktKuTyL1
	fXNnpySWXyvqu03CXKVZWRyNMGo65+cWbV1xO8lJF5cVjg5Q5EQ9o2eHFY9t0AlTQdO7foGXSgA
	nnWUB446pPxCTFYWceRO7kJyKUrSINzAV0h6tQr8rW1i8swg5U69WEX4nzm7VPBZWPqNbaA==
X-Gm-Gg: Acq92OFQeambG3Pogs3wEsyH+C4PQStk/qX2s41PWf22nyhchQrU6W9c+qOxWwAJktc
	OArvpQgVY+HhJCZekO7BQ0sZBJLGFMKS3iv8ACoWjYAvDtpgBRq8vFZ8GNEszRy/AghjaKJYp2p
	z8xR+CFo2vGe3qPRnKeygy6/GGJihxHpsssdjm0loUgpqlNKXyvV7gKialP7Ln+h4NAyGTIhN8J
	2pVpKq6xsn4nMO1Yhn7NTF4ygeNmck7wjvWSNHzf/mUr/XxWU/JGaPaS+krSNtreBd8KxX9NaSN
	eET2aJkcPF2mFa/+ei/ZK/0mDqYAIjpVAhcXtJ5XMS6mhdrmmYuvxO1tJo2RTP3NI1PiD1g5g2Y
	YV7A9eTfMAS0WjxxlUnR2EjlLR304gMYnrBJ0/MNrHw==
X-Received: by 2002:a05:600c:8b85:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-4923773a3e4mr70735065e9.27.1781783688656;
        Thu, 18 Jun 2026 04:54:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8b85:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-4923773a3e4mr70734675e9.27.1781783688312;
        Thu, 18 Jun 2026 04:54:48 -0700 (PDT)
Received: from digraph.polyomino.org.uk (digraph.polyomino.org.uk. [2001:8b0:bf73:93f7::51bb:e332])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa3abd0sm270014815e9.1.2026.06.18.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 04:54:47 -0700 (PDT)
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.98.2)
	(envelope-from <josmyers@redhat.com>)
	id 1waBKY-00000004HGz-3gcc;
	Thu, 18 Jun 2026 11:54:46 +0000
Date: Thu, 18 Jun 2026 11:54:46 +0000 (UTC)
From: Joseph Myers <josmyers@redhat.com>
To: Martin Uecker <uecker@tugraz.at>
cc: Kees Cook <kees@kernel.org>, Richard Biener <rguenther@suse.de>, 
    gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] c: handle .ACCESS_WITH_SIZE in build_unary_op for !/+/-
 [PR123569]
In-Reply-To: <91666e2ff131490d75cf758182d9c47f723e2ec8.camel@tugraz.at>
Message-ID: <498111f0-c7d7-3952-2719-901a44586cc6@redhat.com>
References: <20260618051246.work.269-kees@kernel.org> <a54bcd41c5fc4f4550df157c00dab43939669b25.camel@tugraz.at> <91666e2ff131490d75cf758182d9c47f723e2ec8.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tNbuzjbkai9mgnLLcfEmRdsiPhcxKT61qzwJk6RvpiQ_1781783689
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII

On Thu, 18 Jun 2026, Martin Uecker wrote:

> It should reference PR125604 though.
> 
> Am Donnerstag, dem 18.06.2026 um 07:21 +0200 schrieb Martin Uecker:
> > I was about to fix this but did not have time yet, so thank you!
> > 
> > To me the patch looks fine. I add Joseph (C FE maintainer)
> > for review.

The patch is OK with that bug reference, and with a portability fix in the 
testcase:

> > > +long test_neg (struct s *o)   { return -(long)o->p; }
> > > +long test_plus (struct s *o)  { return +(long)o->p; }

Should use __INTPTR_TYPE__ instead of long here.

-- 
Joseph S. Myers
josmyers@redhat.com

