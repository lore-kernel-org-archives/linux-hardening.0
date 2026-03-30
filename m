Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB83D3335
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876073; cv=none; b=eL9JV2wPxMHwl9PI1VPGBb8sbsKesQEu1zPnuusM2NNgk0kFAqAKMReb/pmAkOF70TbWXFJyPdqKu6WP75YFDqvKpT8kBpx/0uwsWVH4aXEGkU3Gn2cbPJqIKvELRXDMGUameDRDO3Cc3lQEp92IUiYl2wUhYhaVSccEytk4bGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876073; c=relaxed/simple;
	bh=bO3HeS6hOIk64nPeHchB6zoAMO/C28flp4quWOTLF5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jePIPsZpRBS2CMlQ4O2zmQ06SgqFTGkeju1ZQpdsDfXeIj2qiZz+cz+wDS5ZJz7uBtjLS51jBY34J/ufi/Cdkr6E8iQSX7z0YV301V8BJ77b6gWIj5hkWb4VGnKUyT7gCa53wjn6oeviqA/kBTOCht9DSLYoA5U3IE18ej8khbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXMq5WF3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXMq5WF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774876070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai+5B1JDs4Yx5japT2S+wEeUd585BH1Ippqlg9P+9rE=;
	b=NXMq5WF3QGvQ087zxtNJliwVTAqwJzyom4xUopk/8Etbqgfl7ANsQWywRjnJ9p9kIviDRt
	YxR1rrCOvhCwksJ1Pxh+lf9wkAOp2iEnOMoiket2QVhCuJ+c9i1jePMwZZGmKugNCHIROu
	Ch+nfaUFtoHv752eODcx0yqz9i8ZQIw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-61wtWYmQMY-EAjg1Tcelnw-1; Mon, 30 Mar 2026 09:07:49 -0400
X-MC-Unique: 61wtWYmQMY-EAjg1Tcelnw-1
X-Mimecast-MFC-AGG-ID: 61wtWYmQMY-EAjg1Tcelnw_1774876069
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89f670976acso73293716d6.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876069; x=1775480869;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ai+5B1JDs4Yx5japT2S+wEeUd585BH1Ippqlg9P+9rE=;
        b=F1gLwN1GiZzA36GWG7KmfiqxOhkpeQA76H2hxJ3b4liop1QNwJ2ikDd1zAjGhmsStG
         5+CWlj1eaX413j/SR0nXLHXxqFlP5uq1OHGS2cr8kXSPhFMq6tABTJEF85rvHG5dVpMt
         TEdLHmM1I4AIwo7zS4HhUil9+unKgN9PZUoN4KtdrHNoNlralZzHkJ1XY4zebspYjczb
         e9VXfXic4z8vSgLgww6wsRwpd03DuFXzSIqh8iFNZ/3w7yP5tsYUkeqcBlAveikWpTuZ
         AYMgFCrbbcWEfyVQL4unaJyf+bBPY0YL2S1lDEXNtfpZtFRUNoguv8k81yKVPD6acejz
         zJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI6RzTjaA/bRY6dBVPOISy1vmREVa0WvgDdCB8QNU4gm2ezG/U8kvfSDQpK/OiJfRhItQzI3qgYjfWOdgTWVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0MhdR/NBTa1VE/AHkEImRGK0ccf2bab59s3R8nWoym+Gm0S6
	WSPIl6Vbt4dWX4aREqMvmEvxoz8Nnwc9lOwBlQyvuE101fyxmX1DRSUBYYW4iOdlMsvbnajFmY5
	Pc/HoboWbFiKXaXL9xsJPZ5xxUMD93JChm7r27rQ2f2zIBXRREobq0AznkxxvbRhTN0uWZw==
X-Gm-Gg: ATEYQzwN4K8gSYPuRZptdBTD8reTXrZ0a+Zz1ITJP7HkAKxKaenZvLogQBOMHXV0+5U
	Yo1dJr+NXqIkmmGD3s9254kHA/dPvedJ/bJ1BJ2PXntIxqm7H8D1d9AjTxwgRS0QmST7jTOk84J
	hxX1ORqmJp9yLB64ynPaKJONSAkyeeLmTY1TnTNPzXZbSS9m/zzqwzNY0Jg6DFeUObUWKC6wj0u
	drK+0G8AA5f43Ce8oWpSXAcxyusFjikUH/dVV7kVYUcMuBLuEl6ygKhx1iRnF1J78CShzDoRBdZ
	4ORrr5O/U7QanpLGkUpMiqpfT8IzO8UfA3POkEY3AKRaHsqZvn5G6Iwl23n0vLa4aQMPrO+hkoZ
	ZKRyXMO2ZqA2O6+WZ6SyQ6ox7EgTuY9VxXMKdl7BN90OzLRc9ARsqbd+l
X-Received: by 2002:a05:6214:4292:b0:89e:a170:6b13 with SMTP id 6a1803df08f44-89ea1707210mr136977706d6.20.1774876069028;
        Mon, 30 Mar 2026 06:07:49 -0700 (PDT)
X-Received: by 2002:a05:6214:4292:b0:89e:a170:6b13 with SMTP id 6a1803df08f44-89ea1707210mr136976846d6.20.1774876068418;
        Mon, 30 Mar 2026 06:07:48 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf867c24sm63010316d6.36.2026.03.30.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:07:47 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:07:45 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/TOSHIBA VISCONTI ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] clk: visconti: pll: use kzalloc_flex
Message-ID: <acp1of8UeIrtYAqx@redhat.com>
References: <20260326042317.122536-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260326042317.122536-1-rosenp@gmail.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y1NwIgbUYObyDSuHgMHres5q6dIyJJoSGZIU2AUEtRE_1774876069
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2026 at 09:23:17PM -0700, Rosen Penev wrote:
> Simplify allocation by using a flexible array member and kzalloc_flex.
> 
> Add __counted_by for extra runtime analysis. Assign after allocation as
> required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

Note: Sashiko reported a separate issue related to the struct clk_init_data
not fully initialized to zero, and parent_data and parent_hws fields are
left containing stack garbage.

https://sashiko.dev/#/patchset/20260326042317.122536-1-rosenp%40gmail.com

I'll post a fix for this.

Brian

