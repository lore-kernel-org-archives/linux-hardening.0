Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39912D2486
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859655; cv=pass; b=OTb4s/HkpvmP3mCLNFDHqyQ9OAuQEBl3Unh1kyxZD9QNoUxMm/f/aA/Oc8GKwsQqUkcKkCdyVLNHYSZcQdM0XU5NZ/RXZpIukYUjnQw6+KFHooGSOBE7u1/ljcMtnhvpapGu0NAaD51c2wSWxMAUP/HaeehwzIBsTV3BrYb9xT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859655; c=relaxed/simple;
	bh=HmFPXL6107ojfINLEU/+DDvSvZ/6yWqwx4pzMks+SWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B27S8c2p2f490jg4ZJkkWpQO26hT78UQbf71B+nvn8L8SS1JhNYdGn9TBcYtiDzg1P+L7M1/X1aqRmQDD8lclcPS2OHyr0ad+DqOiG/tC81GRMpDI/vD0BmL7Lr2MP09l2mWHwBr+AnfTfzE8uAoIele0VkfzKNgGuXqmr9XM4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=BfXTUMzF; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="BfXTUMzF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84236f9b638so16180b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 15:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782859654; cv=none;
        d=google.com; s=arc-20260327;
        b=UC/9ICmDiX5GWg5YrrjUFdz/ce+WwH2ih7LbBPgnHmNqfGePYWaOkXqpmllxJSmLtV
         q852Mj951ktD4spcCxwyhFpGrQFpk5GpI/vOQgDZPNCC1E7UVQ7hQ1GARApLRYgG/V8r
         juVLxxrmNtk+bWvfQWXxeNBtXZxj60sEcCLXzqe9qyVZC4ubrq2CDtVeo7VilrBP7c/t
         WcihPhuv08EQ/+t54yWq6dd4kqeHsHiCNNGIdt8OqaD50OkGI5Y5RtL6sZHJbFM9slke
         bsjLTB5ug6hcMberyBNboINqY5tcOw5SqFGJwN3eykW9ET+K4gLDkMTYFCQZEFgaAzj6
         U3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q6XSzlODMBAjsxii22kyfJpxbWcVK88QpVIVbQAF0ec=;
        fh=qL+eBbgqblQ2ZJVSCix8s4zC7LdkjsOxLQihTSTgf5A=;
        b=N1FZXpj2VCaI2XV0e5XWHsByA91f+NDImc1q0sAMpKjjurfS3TH/6eSqJ6O6/8Nze6
         HxwzVmYcckCeyTkd0VAthHi2GUjXF4nNGpbNMaB5xhwE6Zi1sZrg9kIdmxeOEvYHH/Yn
         gcn5WRTa98XGbfrBVSirL93zdS12MIbo8ciwEqbSOxgudawRh/FBrIdxz4JBjIOe+S85
         oWSVns66DsRdqUnndBkrqVkvK8aj+fCa0ESzEqtbMZAm7RS1ch7y75bGYoJ5JBOO3KoW
         JwAyPx+TQKq1EAMfnSq488iJOu5q5MbW+JweJceV8YZi25ET3qEXxrB2GxLYtTqFDdKX
         75cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782859654; x=1783464454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6XSzlODMBAjsxii22kyfJpxbWcVK88QpVIVbQAF0ec=;
        b=BfXTUMzFpeqjwAv7gYFvF3RiEnmFOpfNelDSfjEhja1TXZNYi28yv+4NyaQx/zT+7G
         2KlQDT04SPaU2sAhGd2l/uTaxb+oE/SPNx0I8yhjwk7fMSm8yzsmjGXYHqK9bgTe6XXC
         eK7jfeZnwTacDbc8zuquOR+dWeHc8sJ7lDu5AZ9RsBxVHyNMFQB5PgTV0dhrRNo1uMF3
         ljmngfUPEt9V/G3ByC5tNvJV1MtkN2uydxPyCynt+BhozVe/9p10a+AB9ylePVNrxYJd
         9aVYw7cBaEosjAO6V4DM/qn1189Tif4TrpzhvES7hXpG5xjBMr9Qg3Anm8l9r15q6b/s
         IA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782859654; x=1783464454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6XSzlODMBAjsxii22kyfJpxbWcVK88QpVIVbQAF0ec=;
        b=CgP1+8ea+8MNwVie0GrcIAU9NXZ4RU2QEDkZFeGluZJX+omKgeOq47NcGYWx0pkxEv
         u0bocn8KvFbyC89qh2sYMwrVVEw6bTXK4CIfnyKkNOTqBllCnhHaNe8J+6K+zJT+JMEQ
         0lLmbyRB8p/u12UWODdrnBhBQkcgCbIq1dEKrGn0/mYYZOG8aetw4R1TC6QKIfQoDlr9
         hPH90jEsz8aTp3L3T/NtSve3qzOhcPj7SrNp1HmwWCtqLYl8ggEDwjGFH/xz5zEhYDVA
         nNNQNuJWVakBB5R2c9CrTRFKPfsZCkZ8PIgl5aSLAGAKul31juDqRtTVCzV56vi6KJxg
         zDLA==
X-Forwarded-Encrypted: i=1; AHgh+RowNzxIA7prLe3cWy3AqcgkU/S8dpRmqXmJSKxPDnXiPX/LL36JcTtFIqLWbxUcfX7vbtfuS3WqcNVfC27PWvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2x2HqTuF7EfHRq8f6cKq85IK5MVxQSxqIPNGatyC+FkDlpaRF
	24wM6ww2EQHKX12k7aLK6Ee88Q5LFta9gM2cehuE+lFg9bmywMNyrkRw1lpDaeMIp2H+84p4EYp
	nhrJiGtkiiXioPH47HffsHcLoMmX7ZN4OCtgWD7//
X-Gm-Gg: AfdE7clEkUMn3FNlZZzGy6XjHS7Yl1TfCo6oLnzLupo2TgfkEyiiE6ICLNTUdmateiE
	Meb6qtfyG9rra+SnPLn0gUZydwybPf9PZXyXKt+xZ17WsZ5+mMuDh7TUI8UYw7OJ5duaTpwpIQl
	haibW9/GbAY76Y5diIZOR68EvUBCxmW+BO5kBTOEgVW9Hdb2X6/l4n3FqrsDLCfrk0xXgPcn4qn
	/bCxx4bMfjkuXtn17uJYHuJipMcHAn5MKiut53vSEzfSpFd+/DsBZfsiV24YosTE0d16bzKfkx0
	cq5Qzp02VZHMpJm8v/7he+yE6gBg
X-Received: by 2002:a05:6a00:3391:b0:847:8f0d:cc0a with SMTP id
 d2e1a72fcca58-847aded7b04mr2110834b3a.41.1782859653990; Tue, 30 Jun 2026
 15:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com> <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com> <CAPpSM+QVOwhmwspjaUg+FqKsHjiEn7C+gYPEcpJ_UZA=JMj7zw@mail.gmail.com>
 <cb547653-0ed0-4fc5-b022-6f0b9691a4c7@intel.com> <86e805c9-ede0-473c-b8a4-8b20439eaa6b@zytor.com>
In-Reply-To: <86e805c9-ede0-473c-b8a4-8b20439eaa6b@zytor.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 15:47:23 -0700
X-Gm-Features: AVVi8CfeTyAqMwW0h6OqLBV8Qm96A-JxdAHG7H4hcBAlPYhnz7GZ-EseQDFaFaY
Message-ID: <CAPpSM+TM6VL36XAoDMsoCr6u+c0feab8DzXuahjpNfVJQ7g2JA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 3:14=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On 2026-06-30 15:05, Dave Hansen wrote:
> > On 6/30/26 15:02, Xiang Mei wrote:
> >> Please feel free to ask any questions; I am glad to help.
> >
> > How do the CET features: kernel IBT and the (theoretical for Linux)
> > kernel shadow stacks impact the situation?
>
> CET should prevent this from being the target of a JOP attack.
>
You are right; CET breaks the assumption that this technique needs a
CFH primitive.

> Kernel shadow stacks should prevent most stack-pivot attacks in general.

For the shadow stack, I didn't examine the implementation to check if
the working stack can be surrounded by attackers' payload (vmalloc
pages). If yes, the shadow stack can't stop this technique, assuming
we got a CFH from a function pointer in a heap object.

>
>         -hpa
>
