Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB63D3D05
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876491; cv=none; b=PJKXGxz6ewLWT/UB5K4sYp1AgnlLyBTmfMDwkWEuRl4mBCWaEzrP1npfJAYzcBiPR+5xVHSKeYe/qcLDM5WEF4BCgNQnC7RVvMxeaFuI11g077dmSKDp8hZrVZ4VvE2fecLFJAh3GjjlKDC4Wf4xw2NyCa/dzjUHEIMcuJkQZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876491; c=relaxed/simple;
	bh=xWUiPtmlg3QaJR9RozkQ2x30hLtcVMUG8ldWdWVlZh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=glULm31SyWTdIhoaFULi8TQEnJ3K30+7T8t9HGO2gxGiS4IZf9+aks/EOXcbI1xGmx0UdfxVksYKeZzr6xASxuSG0s/jzOGCLFC/8xFbwknxacCROVx638HcT9GLsoi9elxNxi3b022H20gg3UCLZ8GN9gK1vN7aqExHQohzniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H33UnkxE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H33UnkxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774876488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuPmVUCOxYLavRuCQ5BksODHBoPyY1J5S0oJ1KoaoEs=;
	b=H33UnkxEGT2VkMYtbr0LjfnQ2hFl96z6YsAZ7QV1JU3EbgBZCfUzOh55EY0dI8l/LbROSM
	JjwOfbrUgDfKMS+/yD5jbaJIBP/pe2J+2sv5//1cve3iuoiVcNx+Pv07/t6BGJj5oTioqI
	9JyJuKED6y5jGBEr6bUsCuN+q3qWRHk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XkrSZTqKMzODYxj3JKTnKQ-1; Mon, 30 Mar 2026 09:14:47 -0400
X-MC-Unique: XkrSZTqKMzODYxj3JKTnKQ-1
X-Mimecast-MFC-AGG-ID: XkrSZTqKMzODYxj3JKTnKQ_1774876487
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89f1daa57f3so66999736d6.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876487; x=1775481287;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuPmVUCOxYLavRuCQ5BksODHBoPyY1J5S0oJ1KoaoEs=;
        b=G5r60hhpxczLP0RSrELH0HAviuYlACQ3bbsRFiR1VLQrad+fdwwmNg/9rJ2BZz7YwI
         QL3FL/y93mqnHUR9p6g6mj/CGsoGwiDu8O9IYI/JlwOlbqHy81iEBZSBVJIoFyRiN7Fx
         WjZ/4rF2/alQCjEf2p1wFC8HB8A+Qh/cVv53YTgeSpVSWem/gQHNErMHNjiwLWwlrfj6
         cJD3mCU9ws+3c1ZPDzKA0srCHxgcBrjthgJBwFU5blBi9caDgzoBOez45fn9Ab+YruM9
         6ZoEM7uKWI7Jb9pOQdAeAcUbTMy5YbKGSkb1PgJNj/dk48XMpRef/ap8PbnbEWs5G+or
         NKsg==
X-Forwarded-Encrypted: i=1; AJvYcCVOufBgSS9gqRXjdc8qjirNvwgTH5VnAIjjWhilTwNkQocyO0v318ATWEHv6QjVPmyJ3ANcogR4ISki3uxtdTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWScemFme8IQnOVesNWkfsoq2B43ovbaRwqs2gZTCNvIUOS+kB
	FLTVs0nZW6b57KGGZ5AJJaomDr6VADFNEHYh8zR20Ts/6o6M4D8BQUrYSuVg+QCqwWgfGxQSXL8
	hR8iKOfYpQyntZ608moPTUsh5UbJ4eeURxKp07FJwsB5qW71DZpMpcoFpHZkg43zDqynQZw==
X-Gm-Gg: ATEYQzwMhfAyJNAnOfXmgCJkbuDOYcoXKTojmPtZDp8cgZdYzR/hAUHEMS1sHFGu13T
	iw6YMXeJ7/rQtl2ylTUXjxQlvn56ZmBWAR/aO1UJaxQy1c4DOrO07t6xdZ86vdYbO8LqERgLitf
	JiR2Jj8vDUjQbw8uNGpvinp7v2NKY0SxexMw8h/FqoWZdpD4Z9PFafOMRCmAfBfP/yQhaeDyfrH
	+BN7FxCppa4uE5dyWk7sTsgLMeEJM4PP+gshW2a2d/+13cESqlKSVMcTGEjX9qYQMgx6XXo5xbu
	5M2vW6n+HPzQC63EgRfDV9mNq2EPFyqx68Wuir3T2jJ+IOEBzLijC4DaHQYOZrQLm+gfrRKqVYX
	xWs8LNivQYTRJPaiRvcoDOUFclMN5eBk029xTNKDFZpUH5CI0RJXnIhkU
X-Received: by 2002:a05:6214:194d:b0:89c:6bc6:e4fd with SMTP id 6a1803df08f44-89ce8d97094mr180363156d6.19.1774876486867;
        Mon, 30 Mar 2026 06:14:46 -0700 (PDT)
X-Received: by 2002:a05:6214:194d:b0:89c:6bc6:e4fd with SMTP id 6a1803df08f44-89ce8d97094mr180362516d6.19.1774876486400;
        Mon, 30 Mar 2026 06:14:46 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf862cdfsm60468816d6.33.2026.03.30.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:14:45 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:14:44 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BO..." <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] clk: clk-max77686: kzalloc + kcalloc to kzalloc
Message-ID: <acp3RH_cRGNYDpWj@redhat.com>
References: <20260326052847.335089-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260326052847.335089-1-rosenp@gmail.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zO-oWyxY2j03Va6s4WLFeFNH_qHzyT52JEpY8tlufmY_1774876487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2026 at 10:28:47PM -0700, Rosen Penev wrote:
> Simplify allocation by using a flexible array member to combine
> allocations. Use struct_size to calculate size properly.
> 
> Use __counted_by to get extra runtime analysis. Assign counting variable
> right after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

