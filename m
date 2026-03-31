Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436A3F9F57
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965931; cv=none; b=K9pe2dcmBsJGPSdCZzJQvbPGs+tI69F19qd9C9BKXD4Hnr7EEPMb18QV58oFLtSyp1JZaSiBBB2B2fNW6gK3vFBZuWonBLFUw3LrRZg2Xe3s5tpwnv2fmiLtFQYb7KboFB2BsNxpyIW/EQPJfiARFDVjIiQk4jKf99vsQL16Hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965931; c=relaxed/simple;
	bh=MHPubSiQQDuhGllrpi7wOq/Rvc/2bLlTMoYFqbq0jDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rPZnEuJhQkHCtusX+pXwUpwoBVTyWRSgAZELejzc1bCx9+ZJdk6tS4MES2hXDh5EgUGOVGeEmEKiIyVEMbYtrM2SSAxEJsGy33c+Mc9/joc1//91GQsmNTB7aOqmdVTStrBBhQiDi6cm3D50psJFGmBZHdQxwtIw7ZNxboq7Hc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMRjTiNe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMRjTiNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774965928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZCByEtmnsNYIdWYLf1KzEBvQz2XTmeXiioZ2Mxrxog=;
	b=MMRjTiNegYiq0Blnt0B3BzlLV85ZYEwrkxJiShpnJHc9IsSbO+b+Vifnxink4eEhLHJWEs
	GBNXKpSPuNVYUqzhltqRvw0Az99FcW4uFrDZrkEoG/M/5jDMiJjR+nD+yf1kT2pV1ylpuH
	Zfa1xA45G7HqLhFha7S0QE9Zk0EuAtE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499--RyRAETQM8mQ6V30FNglMw-1; Tue, 31 Mar 2026 10:05:25 -0400
X-MC-Unique: -RyRAETQM8mQ6V30FNglMw-1
X-Mimecast-MFC-AGG-ID: -RyRAETQM8mQ6V30FNglMw_1774965925
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfdc479f5bso1609171585a.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965925; x=1775570725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZCByEtmnsNYIdWYLf1KzEBvQz2XTmeXiioZ2Mxrxog=;
        b=nfRytoDDpVxvLn5UUp53CqT6zCqYKl5MKyLE60VK/b0nxoQGV1uteOJDrDuOwITSHh
         RqmhRIOM2RLjZt/Io1VjmP8XXE2zepXFLladl61glc8d1eIl0R8i5ga48QYvv6aIPk7K
         sPHuStqys2tHcJtvq7uWNNRWfu88joGcOlhmypfjGexG2w8JH43iFZvZLsJlndK56aWb
         UerGxaX7HGGh/7D6DpeSQ/K5Y19MNoizEQUUlmF2D55mvGumEIRR8huVqozxZOLBp56j
         JUXxqONBD8tp4TIiiZXSoGwVHLpWz9Ebho4eVqhrF8qxfkC3MATg1+LTyEIxG1IVzr3c
         d2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwloMejSjS7JVucD0Qz1VCabCDqcYqHV6qWsgEoIBxgd3/Z3VcfgXVsJ4Vv2PRtfoYmJjbfljtTHT1VULObD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6W18caks1vsYe7Oq7Riu7HLamB90a54XKXFFFjmiBPqwJwj3X
	MrgtPTwKg21Ct3ivwF1WTX8atpArHuPMkb7m/PAcXmzPmugwK9COsF8ShDc7udyFSkXnoAD/TwT
	DjfF/EhVtsVeFMoNiowwxIUmFSSapybHb0uq/l3ZZhmrXoAuvMcZcCJfzhm08dgh6xdxS2A==
X-Gm-Gg: ATEYQzyTQzxOUuWYL/G9eeEiv8jec3CxzrLTL6gGNHF4XnjF0P3lrbVmIaHo/GIi+Yz
	2bJfQ0y4GWfDrDFSTevDWO5eD5WBvLczYyMGxIicX9T6hdOOmvD4SXZnjJOvxQNBmCZrR6h+9dB
	3Ohv19jT+uGlIFFTMNy8ftn+E2Y+pc7uQki8sVUVnK/nAvbkATYnUvn+pTyi6hRBVeqWbm86/jZ
	fM3A2vOoIoJXZZ4AWn5lmbvr5xAdDNE5sAnxlx6uFwY3zn9498qBL6DDRd2mE+AkGrUVOM6j+R4
	3JZS9U290wx4jU4d0lnr7GgeCI0WbppKRi47F+NSB4FaNgqNmO2xsIioJg5Bkk+l7jmWIjXZRAI
	Jsed2tgumTeRkwqYM
X-Received: by 2002:a05:620a:44d4:b0:8cf:dfc9:c0a0 with SMTP id af79cd13be357-8d01c616e7bmr2226417985a.7.1774965924886;
        Tue, 31 Mar 2026 07:05:24 -0700 (PDT)
X-Received: by 2002:a05:620a:44d4:b0:8cf:dfc9:c0a0 with SMTP id af79cd13be357-8d01c616e7bmr2226411385a.7.1774965924295;
        Tue, 31 Mar 2026 07:05:24 -0700 (PDT)
Received: from redhat.com ([96.66.166.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8e0sm1021432985a.8.2026.03.31.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:05:23 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:05:21 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] clk: kirkwood: use kzalloc_flex
Message-ID: <acvUoSOOF_9UQC75@redhat.com>
References: <20260330205504.10143-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260330205504.10143-1-rosenp@gmail.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8GMm7pl85c89qzgGX4K01LRRdetkIOgJloS1kr0DAO0_1774965925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2026 at 01:55:04PM -0700, Rosen Penev wrote:
> Simplify allocation by using a flexible array member and kzalloc_flex to
> combine allocations.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment to right after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: remove unused goto.

Reviewed-by: Brian Masney <bmasney@redhat.com>

For the future, if someone asks for changes in a previous version, then
be sure to CC them on the next revision.

