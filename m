Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E83C8728
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756244; cv=none; b=c0yT31jE86/Min0ShmcjxSZDTd6xmQi//eJpL5E4Rk7EmmkmsVLq3P4pizcBpfirGNjci3Kh3l+5rB7W7wJ6vxeDy1BynCxH4DoYZJUrkw7BuCtNkDaKif6I5NhYDTQgd0Kfuzf9xt5dGPSHsgAhZvFdNgJi5bNlEZNBLwBmX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756244; c=relaxed/simple;
	bh=a63k0bx3cRG6TjOyfrDArgLRA9ovNJvMUrr3yOCUuxU=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:From:Date:
	 Message-ID:Content-Type; b=FF3zDETO3msh4u/ifpD+83vJdU/gXfq9X065GRrm71zMeah4yftNMEXMCSNDPlhyA2psjkwrHcY/t8OpHbGqy83J8g50t8O7KqKDe4tgPlBwSOz/uCd05avymFyK2mh6GRhplxc0vMArOWuqoMMadidtaAkQX/uGThtmgF8PReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqATTszs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqATTszs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775756242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nffPNSW2MkPDKaf79tbQo0yLAbEX2cyy28WA2Y32fCE=;
	b=YqATTszsbZrD5qn6CO696Jz8RlaSuiYqUN33HL8gYa+oWjtTJpuMwCvl3H+UWg+yyx5rDg
	9n/IRuunquxzsGua6Y/CnppXO7/VJwGZx0dkYua+nADjAm6lRwzw9ScchNsuHay2CFjQAk
	W8/ZZ5Nb/xMsnrAv60ga8uqhfSoN14A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-Na4VCd5XO16VyND_FxAwww-1; Thu,
 09 Apr 2026 13:37:19 -0400
X-MC-Unique: Na4VCd5XO16VyND_FxAwww-1
X-Mimecast-MFC-AGG-ID: Na4VCd5XO16VyND_FxAwww_1775756237
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37B231956054;
	Thu,  9 Apr 2026 17:37:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B331195608E;
	Thu,  9 Apr 2026 17:37:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20260409073711.57020-6-thorsten.blum@linux.dev>
References: <20260409073711.57020-6-thorsten.blum@linux.dev> <20260409073711.57020-4-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
    Kees Cook <kees@kernel.org>,
    "Gustavo A. R. Silva" <gustavoars@kernel.org>,
    netdev@vger.kernel.org, keyrings@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND net-next 2/2] KEYS: annotate struct user_key_payload with __counted_by
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Howells <dhowells@redhat.com>
Date: Thu, 09 Apr 2026 18:37:13 +0100
Message-ID: <2641132.1775756233@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: O_KqdI0uDRgF1kLzRy14R3xuh0hcrFCw6E_erH0JpMg_1775756237
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2442664.1775724997.1@warthog.procyon.org.uk>

Thorsten Blum <thorsten.blum@linux.dev> wrote:

> +			__aligned(__alignof__(u64)) __counted_by(datalen);

Can that be __aligned(8)?

David

