Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D0156237
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983350; cv=none; b=IXdfay5Qs1wxPM027GEtjSawMnY1TmihQPT9dtAZrpRbr6pYnDnUNCT63VPKQvZ3w01znY5pkxb+X5glymrve9V+t0BR0naDzGBBukBdyKzexPCKaQ+BSyzVn3Z1pjKtzjmhIuaMhiebQi6D3cPkeS8lwCM4P0Q4irOIJyQcST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983350; c=relaxed/simple;
	bh=zjUGrTwaUn5LEO0HOCEY0bCWk0oa59RpPixuOMkUiv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoprOtY+sBhIu9h+DSnz3Zc/V+WGDisH/JH+ergmoDIuK3y5IwRoxXAX3VdgeqiTON0KEYf+i7yvwYnX2RNlrTFh7pS6DZvE4yNQxxREJHyA7Dn1xrO9zV8ilJHrytHRJCegwEp5R2WDJE7s1xrsP/M2st+GmITcIyl54DQfP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCvWqW1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCvWqW1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740983348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd8L5wa/M3S5qOwn29qdcGEa3r9OYcaXV/GNXOZPOCs=;
	b=iCvWqW1ZFMK2O24hHlpD3tuz8BxnYbAKkIrQXXlLk997MgOOLrVZ22wyYyzRUa7UV9tLTD
	nGa7eXCkwbr04NzgrMBfJt2GT1oFKo3jzTqNIwHkJapXyNPdGZukw6z+nbEeqzxZ5vHk5C
	em04QI1pb+dw1e6sIPODU7KBhS++6Lw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-bFodggW4M7OAwnOgOuZSnw-1; Mon,
 03 Mar 2025 01:28:56 -0500
X-MC-Unique: bFodggW4M7OAwnOgOuZSnw-1
X-Mimecast-MFC-AGG-ID: bFodggW4M7OAwnOgOuZSnw_1740983331
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 599301801A10;
	Mon,  3 Mar 2025 06:28:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7596F1956048;
	Mon,  3 Mar 2025 06:28:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Mar 2025 07:28:19 +0100 (CET)
Date: Mon, 3 Mar 2025 07:28:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
	sroettger@google.com, hch@lst.de, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
	johannes@sipsolutions.net, pedro.falcato@gmail.com,
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
	ardb@google.com, enh@google.com, rientjes@google.com,
	groeck@chromium.org, mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Message-ID: <20250303062800.GA1694@redhat.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-6-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-6-jeffxu@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/03, jeffxu@chromium.org wrote:
>
> @@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	}
>  
>  	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> +				VM_SEALED_SYSMAP,
>  				&xol_mapping);

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

