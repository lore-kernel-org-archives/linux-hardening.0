Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0E38A72B
	for <linux-hardening@vger.kernel.org>; Sat, 26 Sep 2026 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395216; cv=pass; b=PdpxrxMjdtYNH4V8BUFXwdqCdK26/bW0QKzP9lAysHN0OEudJaRxR8o1FdyCpfN894ie1kD4rj69N5rc8otTzpRwephAVSD3rJ9gS+8N0SyeI3MGomHNaRF+fi1Ce6S+dVn7FhuttOTij1ODoZQIcXhwotzVha5trl5IHcIY4Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395216; c=relaxed/simple;
	bh=8Y2bsAkSTZILhk3+rv+DzLT4+GI9Kjxt3IAQHjbMyP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obqMjFMVgQsJz3JR+kUf171hsMOJTSLaG3fs35nPPGmBZGimp5yjjUFDYcK3xPO56jIxYHxgho7CQglu1wxJFHixI2q+mIcUlQNy6YWcRItDHtVksUsMPwjNMeeBPOOmZGgWfJ9HhSPlA9v4ECF06E/zE/whxrrT3fsgMY3QkHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXJeHREf; arc=pass smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXJeHREf"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-986ee7dee84so83162241.3
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 21:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790395214; cv=none;
        d=google.com; s=arc-20260327;
        b=UiJW7RQbaAy3xQfFZCUeq3yQ3lq8I4dR73yZsGH4lfuOBuSvvEtjw8VZ9ZExgo42AZ
         h2z/N5E/ItN1ujPy5rxso3OMZTxrEXrEvGbloZufrcaf6iOwYxPhfpmcdvLkq9hW6lpZ
         VzsBDo7rJ2ESNF8V/UdRAgUqB6zL+en0B2hFSO4CuKaVP2ZoHQY149nwxQcxcQi/cpnm
         WXG/swvBSROoB+T/fPq4eXLURjszjm6IULM1t0BUtzKd51PRwMrICXoD+QCPlY6z5ltu
         21YIt/TpOBf5YcMYaasKyrE0yZuLv6JspH2mGAnG6Gg1PIBacdGDBkbK9j3qwfhwykrq
         8dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MYpeyRZV+TWw0zn+XSYzCNOx9+tm8LCGwN/L1KGsoYA=;
        fh=a4wU8aQXYIWRqGmavmuIxH4I3i5eQIQH23zEFI20GFI=;
        b=O9zMBsM1lypbABJ8QyznTa0a5QB3GJ3kWpOjDWvkctyq4+SQUlMgKLj4o1UfbWUyEq
         S4rotxe8P+7mCxdLJpm0+11r42zPfZbFRbFrKIr2q7/BLFYvHIGZqNwt23ih3tYglw91
         qWXwZQyEOF6yFDzLx3Wvj+Zy8oqO04RlQ/iwam+A4UGZ1AdOrXlR24WN/b3aXdOr1wYE
         Wj+P994UsPkIaepNlmjJy9qHDChEACx+N7iaLFwQhJnu1cdmwJTPd+RzjKp1OGY4WOWV
         9AvhErwrnvmsd7IG/e+248tODBxBVp/ETwh8QkeiwQz5iZVEwQth+mSuy7EQMHF8T1/s
         m2Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790395214; x=1791000014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MYpeyRZV+TWw0zn+XSYzCNOx9+tm8LCGwN/L1KGsoYA=;
        b=XXJeHREfGdGEpJLhlZEr7bLdF64uLhvzDzfpdZ3JpjZ9Hv9jkgeIyW49aNUkLPnAbk
         V25bb7JZdufoj22umFsGgibbm2lhNsyt1ESZJ0B5NhGfA9bOQnhw/wQfDHS5hwSS+OAv
         1Gs6KJHF/Qkb0Hy1Tke3gEoL6F8ToD7NDqNZd6YIKdXDN78hhoWBdSrNFEPjacECWtVu
         76+7+9GpT0w+oywDNIfTsPI3P2Q3yACJIAVl2cbKIFKy44kWiZsRHzQwBfK5WMajZ6s4
         q9G6vKTotqW4A7kSZn73G5hxmJ5CBKTaRluFdaKIvI/UBvlzNBdhFf/qO6HMLxccqYyr
         rQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790395214; x=1791000014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYpeyRZV+TWw0zn+XSYzCNOx9+tm8LCGwN/L1KGsoYA=;
        b=inwx7LSX5PapD+oEZZSiLmULVwWIDhjOtYGc38coNoLarfQsdIhGESJnXZ0+42GxCC
         2Qfkf0dvpCl+iV7PtgN+NMDGJX7HgOA6N+6H+91/Ms0VDVeESTqXIFtb48dr2tcYRuHM
         L7Jnp/Ysi1zjFyjbBw9e8/JNb7tZeB45vFOXUQCxngwrOix8eazYWsudchULL4K6hTN/
         sPiy42iE+jjvbkDh5XylgxPfiwm/kqJqEhzZF8jBZReVip19lXe0+/wR7MrmC1i47j7L
         gn2P4lrVv+7zpQf/l10X4ylGYvsYFQ3COIt8cegNHI1h/kt1lP+S3mQWggfDnfcm469P
         gKbA==
X-Forwarded-Encrypted: i=1; AKwUvBwMR1Qf9Jb2FTjf1bhFaDg37Ls4I7VJgfzA/ZVu7DZgPbGNrHZihPSwD+sJ20Mjf47FlqvtIaJ9tCTyxnYUxlw=@vger.kernel.org
X-Gm-Message-State: AFuF++k3WT6pAGS8G869OjKbmiQrfOmYP+n3ydJl8cEO4cCNLOCjsC32
	uL/ivB+cSACyyj0Bjd7Og5DI0jB9pzsBbMwtEp51zXLvX/EsbXtpCoKIRbGdsFh4slbtr9i81ct
	EkkkCY/onYJqLV/LhzhwwDP8BGC9yWGtK7PzOwhA=
X-Gm-Gg: AYBFou1I37O0z4aDFBRn39sjTlHAEwO/t9S8w5fXHAusArvafrlOEbdb/VjYZt9OcxF
	FnC0OzPWy0hl94vBEg4WWIpT44iRMDXmHrcYKDlTHMDwZWfV5mAAsWFDaUwhDCC/shkzhPBAqOr
	09mtkY6udIWUJoHCjLbBJFTSicgk8gZC1rHLuKkLxoM1kGwXYPaDbEYZdAFqtMwGdYGdCSzMZ8B
	arCW73QLSbnpJBddpb7veLV9m232gmQ9tEq7zHG7IC7tol1S+8sPYVi0oqm+WLdfIWaImcLr0TH
	WXdOg/vnR3p2S9ZiGIgwthNdmytxQdyVCaBeqvWWx3Q6QZFG5Ts5hI30Ovf719jipJyc04Kdu3w
	3X2qE0LUyNoT+tqIZO9NJ
X-Received: by 2002:a05:6102:290d:b0:7ae:da60:5dfb with SMTP id
 ada2fe7eead31-7af1bf73808mr3668288137.13.1790395212940; Fri, 25 Sep 2026
 21:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055320.2602534-1-morbo@google.com> <a51283e0-7d55-4d06-bf7d-3cd7b7a21faa@embeddedor.com>
 <202609230021.7F6F2140@keescook> <204fb990-7b45-4ce1-8e6a-260538bfb678@embeddedor.com>
In-Reply-To: <204fb990-7b45-4ce1-8e6a-260538bfb678@embeddedor.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 25 Sep 2026 20:59:56 -0700
X-Gm-Features: AclHuK_iI1gG_woeJMTGNDN_cmjTZYiMNuN9pp2RmlztTl9u5AsCWNOE4zKQOyY
Message-ID: <CAGG=3QW43-Kez+FkRM=SuZtbJ_ODgVXY1nrtg7BTYG_OgP3kBQ@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with __counted_by_ptr
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <kees@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:02=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 9/23/26 16:23, Kees Cook wrote:
> > On Wed, Sep 23, 2026 at 03:10:08PM +0900, Gustavo A. R. Silva wrote:
> >>
> >>
> >> On 9/23/26 14:53, Bill Wendling wrote:
> >>> Add the "__counted_by_ptr" attribute to the buffer field of "struct
> >>> vmbus_gpadl". This allows compilers (GCC and Clang) to perform
> >>> compile-time and runtime bounds-checking when KASAN is enabled, preve=
nting
> >>> potential out-of-bounds accesses to the GPADL buffer.
> >>>
> >>> The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
> >>> exactly once, during GPADL establishment inside
> >>> "__vmbus_establish_gpadl()" in "drivers/hv/channel.c".
> >>>
> >>> To ensure that the count field ("size") is initialized before the
> >>> pointer field ("buffer") is assigned, we reorder the assignments in
> >>> "__vmbus_establish_gpadl()" so that "gpadl->size" is written before
> >>> "gpadl->buffer".
> >>>
> >>> Cc: codemender-patching+linux@google.com
> >>> Assisted-by: LLM
> >>> Signed-off-by: Bill Wendling <morbo@google.com>
> >>> ---
> >>>    drivers/hv/channel.c   | 2 +-
> >>>    include/linux/hyperv.h | 2 +-
> >>>    2 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> >>> index 7e4cc6f55237..7042de2dd481 100644
> >>> --- a/drivers/hv/channel.c
> >>> +++ b/drivers/hv/channel.c
> >>> @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_c=
hannel *channel,
> >>>     /* At this point, we received the gpadl created msg */
> >>>     gpadl->gpadl_handle =3D gpadlmsg->gpadl;
> >>> -   gpadl->buffer =3D kbuffer;
> >>>     gpadl->size =3D size;
> >>> +   gpadl->buffer =3D kbuffer;
> >>
> >> I think in some cases these subtle changes are worth a short but
> >> informative comment saying that the _counter_ must be initialized
> >> before the first reference to the pointer.
> >
> > But that's only for dereferencing it... there's no ordering requirement
>
> Ah yes, I got a bit carried away by the change itself.
>
> > here at all (and I think swapping order is needless churn). Neither
> > order is correct: only having them both set before dereferencing
> > "buffer" is required.
> Yes; maybe this is something the LLM should learn.
>
> Thanks
> -Gustavo

I've explicitly told the LLM exactly this, but it either forgets or
ignores it. *sigh*

-bw
