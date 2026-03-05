Received: from birdy.pmhahn.de (birdy.pmhahn.de [88.198.22.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7B30FF27;
	Thu,  5 Mar 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.22.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772695044; cv=none; b=UZ2uUjKH0jjFXHF65NuZbZFggEyflyianfhyChOOj2uALUMTFQyHqUMURnJybUeRT4Z4UfKwb1Czd8vynDdpzAm/t61D1KpokWOQO1HXVbwOJp21OcpFZ0hASlRKrbjybhEyk02iq6YZXIizcrlfjHtO1ojaJFm9qNRyZVfe/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772695044; c=relaxed/simple;
	bh=B3WqYFq7PulkABx+UvDsEHqmfihF6zlRZUaKeuETJrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQHUjV0OaPOzaVX0G5epp2YeqlMb7IBhvYpUZ45LA9H4Wav8RXl4QEorkfn19LZm555EVj04uKXJlJwUwxgvbWsPgzmgj+hXOefs+P7Sts8j77Sy2cX0wGuLVNig3cLJE3y22F3S4sQi6gbs6IKPv6itSi2FTzMmH6N9JsDY7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pmhahn.de; spf=pass smtp.mailfrom=pmhahn.de; dkim=fail (2048-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b=XmTpcH4F reason="signature verification failed"; arc=none smtp.client-ip=88.198.22.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pmhahn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmhahn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b="XmTpcH4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=202501;
	t=1772694528; bh=B3WqYFq7PulkABx+UvDsEHqmfihF6zlRZUaKeuETJrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmTpcH4FZlSFxtbxLnni8kZjglRnFez2NRwhxpbbyaTsTD9SMsquS7S4l50wXY9lu
	 lQiFMjnVImW0PNApCR2qJpXPYou1Yh4BKwKHOf0gQqbhlQlOKqWfi9WUBHxz6ckmt0
	 OgHMo3Ju7jeZCTfr1wON5yxqHEZgytXXzz+ZGIATHtHFfKql2y5M/925w48F3WJ/Vc
	 60lICOR1b6xDXBX7rZuYeReLKh3iFM9kh4rWic8dGWFgYV2ZQs/0quHTeRoOObDt9D
	 GlhEA8kcd+Bt1d62dJrMiWyJikkYDHPH9pzVkfXsJpls60uJm6pjmcBhffRKqFNJ3z
	 JRiCAmdl/Ha0g==
Received: from birdy.pmhahn.de (p200300e2774061005730c4c2e01b5010.dip0.t-ipconnect.de [IPv6:2003:e2:7740:6100:5730:c4c2:e01b:5010])
	by birdy.pmhahn.de (Postfix) with ESMTPSA id 1EE052211078;
	Thu, 05 Mar 2026 08:08:48 +0100 (CET)
Date: Thu, 5 Mar 2026 08:08:46 +0100
From: Philipp Matthias Hahn <pmhahn@pmhahn.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: virt_concat: use single allocation for node
Message-ID: <aakr_hzORmNpme9Y@birdy.pmhahn.de>
Mail-Followup-To: Rosen Penev <rosenp@gmail.com>,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260304221530.15018-1-rosenp@gmail.com>
 <20260304221530.15018-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304221530.15018-2-rosenp@gmail.com>

Hello,

Am Wed, Mar 04, 2026 at 02:15:29PM -0800 schrieb Rosen Penev:
> Also add __counted_by attribute for extra runtime analysis.
…
> diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
> index aea88d1c9bc5..89e223edac6a 100644
> --- a/drivers/mtd/mtd_virt_concat.c
> +++ b/drivers/mtd/mtd_virt_concat.c
> @@ -31,8 +31,8 @@ static LIST_HEAD(concat_node_list);
>  struct mtd_virt_concat_node {
>  	struct list_head head;
>  	unsigned int count;
> -	struct device_node **nodes;
>  	struct mtd_concat *concat;
> +	struct device_node *nodes[] __counted_by(nodes);

Looks wrong. Your follow-up patch does that:
-       struct device_node *nodes[] __counted_by(nodes);
+       struct device_node *nodes[] __counted_by(count);

Philipp
