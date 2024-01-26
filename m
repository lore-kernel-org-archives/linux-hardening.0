Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834ED224FA
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298170; cv=none; b=mmH1yqrDvBmDFfnVXxoIfNBPIBvCAjRengeFm24WzyuJgM5p4gMUwNcX8159GiPD9JcvLrIc/JKw1RXvHZ1L7cB+WAPo872PnfT5p9L+4hhOFUK6wbYp4M1BZtY9f1oa5jjzRvJ3JDeYLqnwBXsv262nBRR5z4ZGBcnnmemgC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298170; c=relaxed/simple;
	bh=l+Dvtec0Umm6fy+Pe70Xk2fhp3AdoGWxoMdBqZkcrNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHOF+XIochwX7nlt0Jx2xwXWW7+/VHb9STV1tXxG737TvCd4G8LSBrHCiuFGhc5XgAP0y17hN8IvIEln/TgqiMBRkvzTVI5/qC3NSF7fzXqbaDmiSq65EaTLLzxmw0DUX65Mj4Roy6s2mGwcXLx+f7llJLiLWjbGE/FdTpqAUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EG2200uO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EG2200uO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7858a469aso5649025ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706298168; x=1706902968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5DMkPLX96PHJXiX9+65dx4WF+ILk2GGzs/YrGWKt/0o=;
        b=EG2200uO/gY1IdvrLAQic9oA8GXB7x+gZgLh+zPWJzQF0BHx0ztyeEaq6ARglNg8Ay
         XXogGsCfh+mWSuv5K1l8nnGjxeYbZC1tNy0Mz5evCBZQu4TSVlP7W5i8k/6dbCoWW3JC
         S2a0LExse0eDY7nxKfFayJBR5vJLC+kNVdGpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298168; x=1706902968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DMkPLX96PHJXiX9+65dx4WF+ILk2GGzs/YrGWKt/0o=;
        b=GT6f76/n6eX41DcF7G+ouFMPjePv0GMtGD6oPa66NVBcyueENwN8tHSLQBFW4Gdyl1
         T1d/0GLPBjeWx64frW/QObwpVLOmNUs9lO4uBq85jNsW5HP/UQMVarQsxUfZXNcITA4T
         MezaGJlknB+PXxoKfVL4AimCarrDuVfblz3Sk0cVUpHvJMxf7rDEl5QcW1kFLHa2E/1k
         aYvYe4x24rvl4i74J3dbeeLAK7Rwv5IAsWBBn1WS+bvL6wuleJzJawvfW4R2qjKsWg0m
         nCF/A1XFDLu15PLgzj+0wJ0pQ72ZCPir34dekMAzSn69Xf6VNatfw7e/jISp2UqEuXIG
         gijw==
X-Gm-Message-State: AOJu0YxE2XEIa6hLOpE5+M3oXTEuCTewXpJzrnkgYRQN7QF4y6pWmo6l
	HNI8dPKM1Kv6tj/lhj+/PeajjN3/TV2Wj5pc1YwYTdZZM+SMKe4DUH96/vqtjg==
X-Google-Smtp-Source: AGHT+IFHN4j5JWPgqLRncyxuWDXfih88qvcwRs7KGjN10AwjsNYqiHieHRDFcg8FReSFNd6bMel2XQ==
X-Received: by 2002:a17:902:a585:b0:1d7:1c88:71f6 with SMTP id az5-20020a170902a58500b001d71c8871f6mr246392plb.139.1706298167739;
        Fri, 26 Jan 2024 11:42:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kn11-20020a170903078b00b001d6f04f2b5dsm1292497plb.30.2024.01.26.11.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:42:47 -0800 (PST)
Date: Fri, 26 Jan 2024 11:42:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-hardening@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/82] vringh: Refactor intentional wrap-around
 calculation
Message-ID: <202401261142.C23C2EC9@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-32-keescook@chromium.org>
 <CAJaqyWdGAb088DxKq4ELBeir=PGrqkRuQ0FYkTBwKkfJa4SWbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdGAb088DxKq4ELBeir=PGrqkRuQ0FYkTBwKkfJa4SWbQ@mail.gmail.com>

On Fri, Jan 26, 2024 at 08:31:04PM +0100, Eugenio Perez Martin wrote:
> On Tue, Jan 23, 2024 at 2:42 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> >
> >         VAR + value < VAR
> >
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> >
> > Refactor open-coded unsigned wrap-around addition test to use
> > check_add_overflow(), retaining the result for later usage (which removes
> > the redundant open-coded addition). This paves the way to enabling the
> > unsigned wrap-around sanitizer[2] in the future.
> >
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: virtualization@lists.linux.dev
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/vhost/vringh.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 7b8fd977f71c..07442f0a52bd 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -145,6 +145,8 @@ static inline bool range_check(struct vringh *vrh, u64 addr, size_t *len,
> >                                bool (*getrange)(struct vringh *,
> >                                                 u64, struct vringh_range *))
> >  {
> > +       u64 sum;
> 
> I understand this is part of a bulk change so little time to think
> about names :). But what about "end" or similar?
> 
> Either way,
> Acked-by: Eugenio Pérez <eperezma@redhat.com>

Thanks! Yeah, you are not alone in suggesting "end" in a several of
these patches. :)

-Kees

-- 
Kees Cook
