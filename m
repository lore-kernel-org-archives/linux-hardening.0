Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A582F3617
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327307; cv=none; b=AlGAmZS0MdmPZVrxk5w2wHj0JK1RPuACN0X7meVbh1SL1yKExE5i9/bR0u/ZjgzzgioxSokc0jA/ORoVKHY8gQkIiqbR/x989UYEFlqcUupXk31esCUQbJsf1yQ2vMTI9tvv8//uO0h/vU2Rz/4aRfs3YqVbhVhh6H144rEL0pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327307; c=relaxed/simple;
	bh=v3Z3ghB7KcUR4Am4dT9GemFH7OfycF4DQNNj2Zkzb0s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mfBo2kttRmS4mfEMl58r0ztP4FP84xZcC1QTjFOvb4BvXV79hCxTn0v7evc4ON1+KjZzlNlYDc9ISS4BV4wSpO67LZA3QBOhn8KVogHVCoag2MoZyUF8hC16kidy01JBdKExMVBNCXE1/TphJsfwk8oUZ6mD5qwYn70GAUfBpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HvO5eXPK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HvO5eXPK"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757327303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrjCytdFkDjnHkRdvcB7fx759T+TGea1zRYHsJqXGDI=;
	b=HvO5eXPK5UWyGF8ldXce/9XHVI6j+ymMky97qOwi6caV9S4ZJSOCkBu32aOs6wgyE5nfcm
	jAfzAhpH0Vgw7ACdUcAepLGHqUi5z+l94twD1SkquuzuBwfIkRe7oZW85xNwfbW7qyHNp2
	uBM4WbsG+3xieB3cZxFx/zm5dehmdcQ=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 4/4] kdb: Replace deprecated strcpy() with helper
 function in kdb_defcmd()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250819095915.711085-4-thorsten.blum@linux.dev>
Date: Mon, 8 Sep 2025 12:28:09 +0200
Cc: linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <10062259-AB0E-471F-A992-0999E0CC02CF@linux.dev>
References: <20250819095915.711085-1-thorsten.blum@linux.dev>
 <20250819095915.711085-4-thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhang Heng <zhangheng@kylinos.cn>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
X-Migadu-Flow: FLOW_OUT

Hi Daniel,

On 19. Aug 2025, at 11:59, Thorsten Blum wrote:
> strcpy() is deprecated; use the new helper function kdb_strdup_dequote()
> instead. In addition to string duplication similar to kdb_strdup(), it
> also trims surrounding quotes from the input string if present.
> 
> kdb_strdup_dequote() also checks for a trailing quote in the input
> string which was previously not checked.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Could you give this series another look? All four patches have been
reviewed by Doug and it still applies to -next.

Thanks,
Thorsten

