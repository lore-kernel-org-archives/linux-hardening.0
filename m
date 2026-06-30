Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031321A9FAB
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856983; cv=pass; b=MQ8xEK9MX9B3dLA0yO6pHduW/0MOCdzY3Iny45tfFx1NVx/tyFe3g8Dg4A6svOBBGfMfyU9mUjRBCBG7cnJvgKFkXkfPWa5Nvnjp/BegPH5j7Da2TmHQePTj1f3zIEduJ+Z4MRQ0ZPJ5z19ym8yHq31D5Prso7qUYwO6SKdCm1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856983; c=relaxed/simple;
	bh=RzpIn8stdWsw1CEAYRVg4vAwqOqXqf36r8VkaTwTjKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuPlhxK/fq3g49syrqEOcvAuqaiXTEa5ZMC16ibFvdrfJDeeI5jtR9CZhdJlbikbEYrP9UDIz+mVojVaDaID06IFWaEUG7rIhhLPVIB4cNOG6ir7en1xCpoSOj3Xc4E1DVBZ69+3xdW/f4PrUVO/wieSzcFLCecN7mwFlcVp6Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=rFU50fDc; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="rFU50fDc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso98805ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 15:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782856981; cv=none;
        d=google.com; s=arc-20260327;
        b=ZlVZu6YjNI8nP+i1In1iGWbfT/8M3WmuxWzOnMtQcz4i3P3ljQXiv34Juigr2IJGXt
         BKfDOqAvrVau0qgor+ufRPrg1uq6sZcqh+GLNdVojNuMsJfu70NlrB/YTXHJcDSnSWm0
         sL1tujIaPQzPwAXbW7yYT0Ieh8stC/PAQwvQ24PnCnk9K/EMkVTHTDkA5JbwAazVkNjW
         0XbL/Te6B40xbSonjMpXqZH0GzY1I8Fw7UdZXv3TN2MU3dlDtyq4/TTCgDNiaiLv74Od
         bCxR8mPFGrsKEfkH4qLSFXsxUlRE/VRUp4rD6/wqxfrqMrswg23v0dZ7lnilHXqpuKHe
         6bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSFCAf4wjFqNBaM6Rce1T2QXaCGyL1EA8pb2O0uNf+k=;
        fh=zYk2q0tWxJP6uuOCbPbAhb/5/8bntv5GQk1BhPZ0MC0=;
        b=rzLnHgcH5ExsdOhR1toNHlcCn4hlUT0jbOqBuhXRfqMxJ0hGeWFgi8NhddruvzijJB
         343mkrP03pKiHhKI1UoDSEKPjrCuBhrWo8wbKSKH9I2J0JsZ7oRAajm20jlZQA8jxF5R
         pCjCfg/wGq5u13Tn+o4HaZSFF7zhwOqqf6PusQDrTswhdr2JKFOwV/3AvDOkK4IAJEPS
         nWWHhjwyA3sMxXwTLF6F4HYP+FWDX5pweBGWkWGJBnkz2oXVXkUKC78ZZTjmfqZk79cW
         JxSbbIceq63ZKEM3XwAdHSh3Z/ra3LaEI7xY23wIHAWJmdF1aO65MsQ9zsgTXCCPRwmT
         stEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782856981; x=1783461781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSFCAf4wjFqNBaM6Rce1T2QXaCGyL1EA8pb2O0uNf+k=;
        b=rFU50fDc89bTOEF0s3dSlX9DDGKWdnYEgZAMXG5iCz2x27tOhPLAGyf9z53j9yLD4Z
         pQ4WCjob+TqdJzIyGfzx5Zbx6vACaqtoXcSFyNsV2q2Hxu+Rcje0tbuTFYOr6z5uOreV
         Ndsc4JcZI0SqX1EC7TXJF2F0+D9hM1ZN95txJY2oUJ5QPLZman2nLiB2mwMQCSPQ3Z8D
         k4qvQnDG8/wY7L+NXE1dCFWaTrrIHPYintFEaeJ5QWxJe8Rok5ecSxrEP+tzE1AI0/dX
         TUNZl8JfdPOqtkUbhjr2twhS6Y5AKIlG8w6QLD2RbC+zBIG22CYJw58Q3hiw99akU1TH
         NeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782856981; x=1783461781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSFCAf4wjFqNBaM6Rce1T2QXaCGyL1EA8pb2O0uNf+k=;
        b=d0ejjS56yX2and5/PfLNPeEi/Ya1mlsRzM/3kbzf9TMx+KSED0dcRCpOc+Y98SJJVa
         N+xAkMu+uIuTCczn1qlhmIshX5h2n8DZyf7b4MrYMqxTRiyCgdeqIvVNYSAKDPALf/g0
         s2CgfFb2LcADgvJNCIzMHxQ/mNqdw/Rki3eJNAFQnmxhQvgNOUSPizRbj94fu4IKaraB
         hzcTCXoWA0qkPpiJwR2yXvAEJ8iV8olMI+xEm9yZUuXAlTxu31jVnv0qzjd0tnEMY9g0
         tIew8hpGVcU8u483PSnQtVIECsp9Ycqh7wxLJEswmijuaC8VFP4TrX77ycoOEPlas7k8
         ds3w==
X-Forwarded-Encrypted: i=1; AHgh+RoZKoNf/WugRbZ5ZoXUYtWu6yaOTHEZvdbm4bKG0g33d3VjxWfCN+SLHVIIEZE6JWw44CEFSPI2NfWD7oNpRBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQ99RoSd8PkEdnBTyhKQg4EUssOtcY6vGe1e/WRXArqsoDrHj
	8B8SS+I4ExzPrCTcq4ZV9XpBgO6kQZv4rvgdxRvJKHJJoHss26ftoEXfpsdwy7jA4pGMYAu4/81
	FJUd8Hc3fSoxR2eLK+Rw+WPau6jhXDPBJ2vuN/7Ch
X-Gm-Gg: AfdE7cnAg8nCGbR6ZWXyCAHOCA4kt4SCAbe3tasGv9fbP8hdFtyAIWPSDd8LwYoLN3F
	PJiswQWvGhfOtp9/4mXC6vQ8XKcOC+IIGrq6UxoS5KFrxlde9sHxTSO6nEKKEXWoL1YVNNONDBd
	JaAs1GQ12u8A0riZw8wjxT2y5gRgoEd3GdJM+5Q0pkq011POcZmZIhtHq/lsyYb+F/UnHeT5tOO
	BQH0SHVsSR/rZq5T3wbxAsCs6mmW4XA+2nI/JCYW6pC5hVm3evb8e5PtvYmYY2zYjsj4gx+WW+v
	74LI8nyzwIupt9Ai+EiZjDZ/fbyf
X-Received: by 2002:a17:903:1a0b:b0:2c9:97a8:8c1a with SMTP id
 d9443c01a7336-2ca2eb2f98emr40338745ad.45.1782856981284; Tue, 30 Jun 2026
 15:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com> <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
In-Reply-To: <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 15:02:50 -0700
X-Gm-Features: AVVi8CdRnHt8kHQRYUk_bp7t-LCebSEbC70Greauv9pAtqRFDRdkvcC4EgUDnu8
Message-ID: <CAPpSM+QVOwhmwspjaUg+FqKsHjiEn7C+gYPEcpJ_UZA=JMj7zw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 7:02=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/29/26 18:22, Xiang Mei wrote:
> >> Please don't even try to send a v3 without addressing this.
> > This is a demo exploiting CVE-2026-31419 with this technique:
> > https://github.com/google/security-research/pull/397
>
> Thanks for sharing that. That's really good info.
>
> But what I want to hear a bit more about is why this new guard region is
> a good, generic mitigation. Does it help mitigate a whole class of
> vulnerabilities?
>
Thanks for the question. I'll change my words to call this problem an
issue instead of a bug since it's more like an (instruction set +
kernel stack design) issue.
I have used LLMs to evaluate other Intel instructions influencing SP
register (plus checking if such a gadget exists, e.g., `add rsp
0x8000`) and can't find a second gadget that could be used for stack
pivoting targeting adjacent pages.

> I think you're making the claim that this ENTER technique takes what
> would normally just be a DoS and makes it fully exploitable. Does this
> happen for a lot of DoS bugs? Or is CVE-2026-31419 very unusual and this
> stack guard gunk won't ever be useful again?

I may have written some misleading content; let me provide more
information to correct it.
ENTER escalates CFH (Contrflow Hijacking) to ACE (Arbitrary Code
Execution). It can't escalate DoS to exploitation primitives:
1) ENTER is an instruction, and it can be used to perform stack pivoting
2) The ENTER-pivoting technique requires a CFH primitive, for example
  a) CVE-2026-31419 is a race condition, and it gives a UAF
  b) attackers exploit UAF and control a function pointer
  c) attackers change the pointer to be an enter-pivoting gadget
(e.g., `enter 0x8000, 0; ret`)
  d) attackers escalate CFH to ACE
3) ENTER-pivoting is strong since the gadget is common and **one
gadget** is enough to escalate the CFH to ACE
5) Before this gadget, there is only one public one-gadget style
CFH->ACE technique: jump into BPF JIT (mitigated by JIT hardening)
6) This technique can be used for all CFH attacks, and it can enable
some hard exploitations (no register control, BPF JIT hardened).

Please feel free to ask any questions; I am glad to help.
Thanks,
Xiang
