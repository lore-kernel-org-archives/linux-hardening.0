Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE01519B5;
	Wed,  5 Feb 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760594; cv=none; b=Hh4moKPwQJ324i0tm+hJDUN0KV9g3nr+DHcRNQO7BJyGCM/k57D0jYwkZO849zhXNyk02052kQGYeW/tMbT4ywqBhAL/mqBzZYCf2N9gZhbUKiicvTycTOG/66W83V1IpW1UUNSGNIfxeWzckPMcyC6cZhEgO7B/Rxa8g4h4iQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760594; c=relaxed/simple;
	bh=nI8viFGtlsOfSmanGI1tT6F5OI8BJQFYOe7E2gPk/1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9kUUzE55aUNMkiTj4HdP9LFg8fX2Fbdox8J1zhAA1+I88JLwFq346ppgRLWQ1oaohPi69ZmMe6olmQ+lnUrnLBPKM6RZIRUuFnvCQgsc9c3x7Uq0UeHxu5eTF3bPedNXwiE8R/qx06Rv6b4tcoH5xOhu3nT59FGGDoB8hnpMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AxdOPJf7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AxdOPJf7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zT3qn3LxFROI28EXPqmhKqMP198v9nJbaPl+MbrDq2U=; b=AxdOPJf7vIdtl9YiF6AKJUFSlk
	/E6YG8NW6n8NxjY1hAASdKmgm9exQbnBTa8yfkAolxzhi5UrajxL/5KKqsKXKpyhQ1VqBzoe9/d61
	ssYJr+8DI64xBFY96EEY/hZuBmE/EaiMS/DkDz0HUB5oX3kP39/kDNprtujseyQeyVdoMwB2LH6AB
	fBlWARukLZQmIJk+NK6ge0AR8GxQ5NuCTxOoGwyF4Q+6kpB/NLl9N4iQrMr5T59GTOSb8EhY4KYsg
	wUAso9ghk/c/VWOce/++WUPjyw+tAkwXsnHLfG7ncqeOpera9JcX2SMf+005qerLjPMv3FPTSBAvk
	a4JmeNzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tff3c-00000003wYf-32U0;
	Wed, 05 Feb 2025 13:03:08 +0000
Date: Wed, 5 Feb 2025 13:03:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fs: hpfs: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250205130308.GC1977892@ZenIV>
References: <Z6GM6WIg8f0Ql30E@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6GM6WIg8f0Ql30E@kspp>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 04, 2025 at 02:13:37PM +1030, Gustavo A. R. Silva wrote:

> +#define anode_btree	container_of(&anode->btree, struct bplus_header, __hdr)
> +#define ranode_btree	container_of(&ranode->btree, struct bplus_header, __hdr)
> +#define fnode_btree	container_of(&fnode->btree, struct bplus_header, __hdr)
> +
>  /* Find a sector in allocation tree */
>  
>  secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
> @@ -27,7 +31,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
>  				a = le32_to_cpu(btree->u.internal[i].down);
>  				brelse(bh);
>  				if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> -				btree = &anode->btree;
> +				btree = anode_btree;

Just for this - NAK.  And then you proceed to add dozens more of the same.

If it looks like a variable name, it must not turn out to be a bloody macro;
if a macro expansion depends upon a local variable with given name existing
in scope of its use, make that name an explicit argument.  You manage to
violate both.
