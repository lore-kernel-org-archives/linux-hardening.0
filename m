Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1B492E28
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908491; cv=none; b=kZHrywyCBYwUeipnf+AG1YIaJYaw92PyKNhgvY/D1MOt3fF9m+EBB0ChOcauCLlOxQr4y7bLWBw797MZNBn8laNLxaFY6/h7F+7ZJwMr79fdPBzTFEBp/tnFiVu4QxzZAOP1P8cCgnTrxS8omZI8IXFcHJqYOVdrw29OgN1YbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908491; c=relaxed/simple;
	bh=Rm8WX1xe0DoMo3D1FxDrPDxfUykAkXe8SqdtbTEnEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QUoHOYn1GzuFRIUwrjlpQJiQ+oegUiWQE0c1pWNlJz4xMXKkEP7/1ha2RdxeFzdnpK58DCuXZfRn60W2KgUSbPA3MKITIaNocQHTZnhoLYc5xXkBrFLZrWJgUgrc4OiNv07z1cleVAQnazZd57z54xHc1tQL+ez+jgA5TK8eF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOg7BfqZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOg7BfqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788908489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ynGziBWrLSR0Afz+gjEtlGctM5W9fhdVmYGZfqUKAWg=;
	b=gOg7BfqZi3rS/PXGikRbrre9GanwFLVA0arM5u9xANFEg9avBWM5TOWZGEs84h5Eg42IpX
	xdOOS1u/A+TYDJvFvWv9Q7AbCJO9rMAW1LvlNeio4HSaR8VdP2f9Wk1pE1Q/XjSvEfv9T0
	xFLnFf4DKyid5i0IB5b5z/EFbogOXp8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-VtrH7BDWNuGsHVzfItdtHQ-1; Tue,
 08 Sep 2026 19:01:24 -0400
X-MC-Unique: VtrH7BDWNuGsHVzfItdtHQ-1
X-Mimecast-MFC-AGG-ID: VtrH7BDWNuGsHVzfItdtHQ_1788908482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 795F81954AD4;
	Tue,  8 Sep 2026 23:01:21 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 585551800347;
	Tue,  8 Sep 2026 23:01:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Sep 2026 01:01:21 +0200 (CEST)
Date: Wed, 9 Sep 2026 01:01:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bill Wendling <morbo@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>,
	codemender-patching+linux@google.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 1/2] userns: Add __counted_by_ptr attribute to struct
 uid_gid_map
Message-ID: <aqCTfVdDOy5ZOx6c@redhat.com>
References: <20260823125155.1136740-3-morbo@google.com>
 <20260908222734.3048684-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260908222734.3048684-1-morbo@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: m_Kr8xW0RgZB4uZlCn__RGNNnnwQuBL9GTotabO2-DY_1788908482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/08, Bill Wendling wrote:
>
> We can add the __counted_by_ptr attribute to the 'forward' and 'reverse'
> pointer fields of 'struct uid_gid_map', which are counted by
> 'nr_extents'.

Since I am CC'ed again... (thanks btw)

Personally, I am not a huge fan of __counted_by_ptr, at least in this
particular case. But 1/2 looks technically correct, I think it doesn't
hurt ;)

So, FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -809,13 +809,17 @@ static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
>  		map->reverse = NULL;
>  	}
>
> -	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> -		dest = &map->extent[map->nr_extents];
> +	/*
> +	 * nr_extents must be updated before the extent and forward arrays are
> +	 * accessed, otherwise KSAN will assert an out-of-bounds error.
> +	 */
> +	map->nr_extents++;

Yes, but perhaps the comment should be more explicit...
I mean, something like

	... otherwise KSAN ... because of __counted_by_ptr(nr_extents)

Nevermind, this is just a minor/subjective nit.

Oleg.

