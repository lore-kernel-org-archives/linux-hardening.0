Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981832;
	b=qP6QjkYCpkiZkB6R330G+G8eQpkcsge3dZDasRP3ejWQWbhy0lYfMdRG1dX8Cz/WUODW
	 9tAJQPpCwLsYS65imp3jfRrv7wrKu4gHvBandnyJsm+GD0Y8ISxj/8EP9n+2HZGzfyezF
	 oysaplVA8TuPqjkDtfC+U/yXgR9VB/B+9UXypeqAev/X+V1aLBNYyTl/ojhY8AlL1Ikmq
	 STb51PujN9XtpeGEQIJ/7zqwNRMqbZoV2kAJP/dih+PWbg8rjAKLnSpco2V8sCmpRzdx/
	 0pgLqVFz4qHq+NjQopvOuCz7mV05pVrP6RrDbMQgVUiPvDgjDotrv9KJwJUcjBgN8qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981832;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4vnxSUhlNZMc5VgAuiwlmUZxxVhCPab1IPs6yhqsipw=;
	b=1FEFwlzQeSP+zpZh8CYRdFmv9g81HXX1nnOhlLEQxKLxb9C3WGZQwHN4UuqaFhPzF4+8
	 c/94dfGb+kJnaid6xIwEzAK2RixYieoe464DQSlZcfWhlZV333TJquh6kb6hJMWVMU1v4
	 Y8T+YNEROe6J4q3BM/s8oDaVCbAirbFS8On5lzZmlWaaqk8fVeyl/db/n8t3gTGLWOlCN
	 +1+aCzUA9gAyhKdXryuF51nZhuztPGuk1M+VyoBLGXS/WP5etCR28TJO93GPIOaZL1ry1
	 oY/nqSLygdQ7xj7vbXr1PxFQwY8rVxfFzDj36T6ZMm4+b2s5A8SdNWPDTu3rOeWA1Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=G+0UpL1v;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25011606A330
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 16:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25011606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=G+0UpL1v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=4vnxSUhlNZMc5VgAuiwlmUZxxVhCPab1IPs6yhqsipw=; t=1793981830; x=2109341830; 
	b=G+0UpL1vX7nwetm+fkjQ11F8ICC8MGtIg1hP1lz/1hYHmr8MNCgJ0dWDvoQDAtIi1XyXOF0dIQc
	odIB6sD2shhK1YehQ9jR6dO7//fz6qFsoyklOvTFdwNzpSWSArFqxe0z/e9UAYvmZ0Sgbf0aJv/8A
	L0JNpRWRZZtjXqVmrULGC27IWe6pamDgL/+0UXRphtNeYNgcQlx8E49OKUHlLYNNamtNWy6P/cZGJ
	bS8H43bEVPmqH5NYwLcJT6lMBw0JxCsrFYAy3dhkOM0ABOKc3i614juWwpAdzKGtkJq0WLdql3J7m
	5xOvOOBPU+J0wqWitKhmMUdPRjjKaoSXSLtg==;
Received: from [189.110.51.50] (helo=[192.168.15.3])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xPMch-004Zqs-7w; Fri, 06 Nov 2026 17:17:03 +0100
Message-ID: <b7c0bfdd-860a-14c1-6c04-10c075411dca@igalia.com>
Date: Fri, 6 Nov 2026 13:16:59 -0300
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 0/2] Improvements on pstore user experience, take 2
Content-Language: en-US
To: kees@kernel.org, tony.luck@intel.com
Cc: linux-hardening@vger.kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net
References: <20261006203412.175427-1-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20261006203412.175427-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2026 17:22, Guilherme G. Piccoli wrote:
> Hi Kees, Tony, all
> 
> here is the second iteration of the patchset.
> 
> V1 here: https://lore.kernel.org/r/20260922212532.98571-1-gpiccoli@igalia.com/
> 
> The main changes of this version are related to potential races Sashiko
> caught, and are hereby addressed (hopefully!). I put the diff V2/V1 in
> each patch. Lemme know if there's anything else to improve and thanks
> for reviews/suggestions!
> Cheers,
> 
> Guilherme G. Piccoli (2):
>   pstore: Consolidate compression handling in both init paths
>   pstore: Allow kmsg_bytes parameter to be written at runtime
> 
>  fs/pstore/inode.c    |  8 +++++---
>  fs/pstore/platform.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 41 insertions(+), 11 deletions(-)
> 

Hi folks, gently monthly ping - is there anything else I should change?
Any feedback is appreciated - thanks in advance!


Guilherme
