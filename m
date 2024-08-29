Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E81B5EDB
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961263; cv=none; b=Izvkzi8HHDUTHoV5wu1shPROAmkh+BiCI7ZP6LzkGdGBGTa386P357eZ+l874afrKcb3WpQank3HertafSvnV3wuL2uzEh0gzsroImahkVlic+I4AXK07LFiqapb0ViURdvssGt2ZX8Bbp//zNSWEfqgItaqfujBOpulraC7Bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961263; c=relaxed/simple;
	bh=guVxu9HxEDSLtaNB6zapABbY8BPidXJ8qvB9HSCs1b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aD7jjjp3r4J3X3VdutU9zJeARIwuJKffMMzv5fcxjgBA3NviaKX6Pq+1zDoInNLCITbi6GowIoQddZkLa2IHeCqzckFee+Ea+9lDgYTKKK1G+/CsGituM91JaBzA+sBJqmzgwuHKsoE1r8CA/V4cqy8aVUQvhtgGfoMkVRrZJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bk+JaODB; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bk+JaODB"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-26456710cfdso80376fac.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724961261; x=1725566061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guVxu9HxEDSLtaNB6zapABbY8BPidXJ8qvB9HSCs1b4=;
        b=Bk+JaODB/0OHRkcroTeTsHNL5sOjGHKhXIqPuyHkj0m8ORBiRd03qZyTS/HiGI0e4x
         H9Olr/h5SLMWEimLzz8M48h20/QKV4GTA1NkAd0zG4fbLC9fI3nF9UlwzXKttubxzsVQ
         0I86QweIed+z6C8Yx30z7rr8aYzjre7SOtLSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724961261; x=1725566061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guVxu9HxEDSLtaNB6zapABbY8BPidXJ8qvB9HSCs1b4=;
        b=Og3E3lLymwtTH6gGMtu0pk5QCGasNiV1+7Fo5BEetn0qJTQjuaHZMO4lz7ICbpq21W
         2WBoYixxrXtl5YmSKYuWS6CcIGVUk9EuWt2barCISozIjJSD9hcvjRZ+Y/mD9lw+jGSv
         e0VF8tw8Yuk9QoIPh/ZPJIHyspyNVKE8OTKuYjQSjpXpKxEBUsyBVTMD3mEr4ThXKlke
         esnJFv+adR/h4HASb8vPMtl4OQAlfCTlNtfpvBH/0V/SX/1Pc+eygejVOF1dJhWl++i8
         2RIrbPP94xtL1wMO3KB3VDnCp18eFIFVPALclPRykTUzE9CsgbGnYZteLc0Ex2Iouv4M
         saPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkGNNdOmn0WfBWnGSRJs0R+YvqtK/B0bbaoCkTfApU1O1pWmoSDXLgV/qnUXLJTU2+ZamioRi0vumNq0h0Kjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9Dz9gPBWWKnU5hJPzukbB6AId3tIey3GUecfTnTjcv6aeURf
	IN6UmOaHvHni4PrWW/v1L4AEXCMMTyh7d49sqayyD4KJ8MR8lNoUwGpt5gLVxuBDJo5R+Vfsruo
	Dh8KBr9PTfFtmUrdxYIJ4d4v0PTVFhCalAABYh+qvJhLxEW4=
X-Google-Smtp-Source: AGHT+IHRaSJMxiiEHHnyyPMW+E6Zchvcl2ZBtiZzi3ND4sx5NZsr8zR9UFo54QC6zM0irr40VOAnC+AYh5/ejQvMlDw=
X-Received: by 2002:a05:6870:fb89:b0:260:ccfd:1eff with SMTP id
 586e51a60fabf-2779031ccd4mr2354479fac.7.1724961261302; Thu, 29 Aug 2024
 12:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
 <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local> <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
 <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local>
In-Reply-To: <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 12:54:09 -0700
Message-ID: <CABi2SkXDVgiUeC1StbfggvtiYG_kDxQJsZPpDw-NDPNv6-dwmg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Thu, Aug 29, 2024 at 8:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:

> > >
> > > Also, this is a really unusual way to send a series - why is this a 2=
/2 in
> > > reply to the 1/2 and no cover letter? Why is this change totally unre=
lated
> > > to the other patch?
> > >
1/2 has a fix that 2/2 is depending on. That is the reason they are togethe=
r.

> > > Can you send this as a separate patch, preferably as an RFC so we can
> > > ensure that we all agree on how mseal() should behave?
> > >
It is not an RFC because it doesn't change any semanic to mseal. The
updated test will pass on linux main as well as 6.10. The increased
coverage will help to prevent future regression, i.e. during
refactoring.

I will add a cover letter, split the tests and add more comments to
help the review.

Thanks
-Jeff
