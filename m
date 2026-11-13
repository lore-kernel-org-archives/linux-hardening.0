Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559940;
	b=DJ+chNsdjO2/P59mGBD/DpubcnHUTTChdAmZKff1nZyRfYH0VGlJ+Y9C6qplhgF6cKk6
	 elYffaZxlfJtExsSL4uQcXW7lKVR2B225wHyXxe7sfiuLsNddeckNjZMiGPGvK4gE1Cb2
	 M6+nn2emPqybyYle8P6eiWkEseU8o8MyEWiTCRjK8VcnjHJsxRICthmQIcHGSHrTYHgS2
	 AMrxWHZyw1f42PZveepIPVs+8b16nK7e+XR4Leupgl7N0nipi7vmhtLZP6ABJQUyo8+dx
	 jVgWYw2Thy82XNs1GSMTlwfOnkvWmfC2N3CpH0ToEovHC7kLFPj/YmVoSjK12eEZA9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=e4bPcAILoFa159OMZMpYEpI9iPNGmEeupM4uWcOHC14=;
	b=d5NuqoD8OUDf25AluwBktcF/bxpjg4LEgX6IFPmIScvsL34V8SLXgOSJNvtssY2xm9X5
	 TZ3f+Jg0oOaTDD91Dcda7WbKA1vcwOJ/M8YrdemJl+iajVaQL0kCBNhiwrARNJ2hOnwmY
	 hMGue/JTPjyVv6KtMZ4/8WxvebgUpI1OYtURWj6dn1vv7RJQaewRHL91wTfTdTdakrIyS
	 e/1hZ8jSIQ48JLIHT4Gg8FqhhL02ATlnKwXLksBNquE/zn0xFADd99VjZ28UUvhFD7o+C
	 TWwQ5W9WBdeskuntNAITmPw1lbSbA5j7G+uwwicLQmvfDFoGzbF3JhbvpJ6q9YMRf6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=sfmDehrG;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744B606A8B4
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2744B606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=sfmDehrG
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so1114500a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559939; x=1795164739; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e4bPcAILoFa159OMZMpYEpI9iPNGmEeupM4uWcOHC14=;
        b=sfmDehrGMuC54s47QTefOIcfqgHZa+7vrS3luDVNdnTqceF4rooXYxrQi01jbYr2C1
         C3fd0Y8Nclxu64x0i0e1Bikk49Nm9JsIcmq72LvL6YluDn5JL3hXTo1Dof29YystGvwv
         IghGCSDCUaX65mGLt5jQD0af8fBVNV0t3+GDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559939; x=1795164739;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4bPcAILoFa159OMZMpYEpI9iPNGmEeupM4uWcOHC14=;
        b=mUAx3PF7Y4CZIupVTX0Lm9KfY1SxWwzpZBq9aX5wuWPuR5D/fR/ZRAFq0B+oIix5Wc
         e6pSdd8gl3+UWXKeNoOdF9lvQzlvjYIl6sm6Kc714eKUN/rzduapX8xJDLJDUkJD5Iol
         VVag4BVu9ltHW7POyfTvl+Vi7shFE3tF19HzZjjSNkJ4qTzH5MreSCMExiMCIhPwzEfS
         fJ5EG3evcJilDWIaHviYq7tDlfNhIa1pn53ZSxD7H+QUUMRq6+uaDlXZx59X18SyMvPF
         dNt3AOm2z1o4PWjLfKQBsoSJq5U2DgS5d0WpDSQN+VowwHZwZJFScGgrooQSNkE0FELY
         akMw==
X-Forwarded-Encrypted: i=1; AL+hErFlRvl8jwE5EiEPXa5F10xwk9di6s/1GlxrP40BFBBn1FIg1pkityfqY43hiP7WidJcpqpLUBq7KHZs3kp7ASk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CJlPoE2b4ejyOGClMAizU6MD/p4eGbBHq5d03x/zRA5rmCfcf
	5sV5GCrJCcJHN39ftIHh2i+eY2jH64PljUjz4hb4xRlHhu2wPFnU7pig7QVYAMQpMhs=
X-Gm-Gg: AYBFou0GwtMhPKjQAfSwqKden/m27t6SpVnyCAoClYJU/qK5b9oAKcAQp2gc/PciIMp
	G7P9gcVBzoph/QgqEPdQyKBUFNblNQkVJcKipmWuL9IcG5ka2TlUddiTWJbyekOVf5J+76bI1P/
	5zwEZNuUMKEswfOvNN+eeBBZFzJ8GVkQ6Fp35yr2skL669dUgaUDfgzdAjF0A8CUInXYCxYq0gB
	i9g9QtwFfZfYQ4XaNqhRKPr16HjrYM5VPIQYvPMQ2OjXgJbWohP8gFO65rkQZ+anhjP2Xgrp/8V
	XIzmGHa4XwxHHPq0QxCSkRyggWY9b73nkgvrUm5SapaQZgO6/CCNpJlaq+/VTdFE26ASmgnEQkt
	P1GNACMLcqdjneX+shUWP8SAxRibv1hMd/OJrES8zxvY+r3QYlz2ssKWhm0Xdh9yZ4xU+BPhDpx
	I6ESJAzIe6nXzgbZKMKYmzDGARFlwuxj9ptLkJW8ArjrGuTRFUt672kmjryjgR2FtBUwb1uLpnA
	XcKK6/ab9Pbf9vh4zAHjH8aRU7p2EZTGLzygnXpaclDyxh3OPonbKR6Q8cx4pRBHLHTS9a5w3Lb
	WNb8SNZnMKP3qEEhfUo+MyJtLtepmaANbkfBu0XceSR+4eFDX/Vjs64MwpvaF8TswQu8aDBvkyB
	NE1gx5WgAWlb5xhM+1LMRwdf4JRKQ5nSbXtMGdwZHctAjXhJksGL22ao3m6QfoPLu4GFGE3Qpoc
	GQlolEUYyhwztQGTbQL3LHTR/AsDbBXGUO14rbv0ecEVhXOq5fdo4jOKLKIF8=
X-Received: by 2002:a17:90b:58f0:b0:3b1:4eb6:b3a with SMTP id 98e67ed59e1d1-3b1b081887amr1718429a91.8.1794559939633;
        Fri, 13 Nov 2026 00:52:19 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f4ad534sm7140735ad.9.2026.11.13.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:52:18 -0800 (PST)
Date: Fri, 13 Nov 2026 00:52:12 -0800
From: Chris Down <chris@chrisdown.name>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 5/6] mm/slab: Support disabling KMALLOC_PARTITION_CACHES at boot
In-Reply-To: <202610302123.687A961@keescook>
References: <cover.1793253633.git.chris@chrisdown.name> <617bbfdce4fb2689c2510f0cd7f9adbb3ab8edfa.1793253633.git.chris@chrisdown.name> <202610302123.687A961@keescook>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113005212.556c6f234712bdfe@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Kees,

Kees Cook writes:
>Swap the ifdef for a CONFIG-controlled static branch that defaults off
>without CONFIG_KMALLOC_PARTITION_CACHES.

I've dropped the #ifdef in v3. kmalloc_partition_enabled now defaults to
IS_ENABLED(CONFIG_KMALLOC_PARTITION_CACHES), and kmalloc_partition= is
ignored without that option, so new_kmalloc_cache() doesn't need any
#ifdef.

I've kept it as a bool rather than a static key, for the same reason as
on 3/6: the only reader is new_kmalloc_cache(), at boot. When
partitioning is off, kmalloc_type() still picks a partition index, but
every one of them resolves to the normal cache. So the flag is never
read on the allocation path.

The one place a static key would actually help is kmalloc_type(), where
it could skip picking a partition and go straight to KMALLOC_NORMAL.
Since kmalloc_type() is inline, that means exporting the key to modules.
That seemed like more than this series needs, but if you think it's
worth it I'm happy to add it.

Thanks!

Chris
