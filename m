Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C52376F0
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883404; cv=none; b=Ro4QLZisNReoUlvEdaBW5BumiuIh+sHRuSdI22pEp1wYrpTzavS4DzgDfSdjweJZNjohWajk8V2Bs9ziAJDpIJ0NC26vcspL6ImBoN0ou39UCRbmeqE/R0gkkUaX7uMQXTD6Gk5jOlf4oFC0379Rv/GpE+TJ95TDLJZSUXpJU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883404; c=relaxed/simple;
	bh=kPQLaiE17kEvtVVIcklJiOtE0vJC6esAyz2PHe7aHgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlfwFZ5KJnruk0JBQT6nT7r/GIwqKaHARNmfYdZGaK9z18VsMobaTYELiY8Jt0t54+hKW5slI6IQXvANhE1DtjoHJv4tkr0NuWrQUekwjt7zHXFjzG2oV91zaYolzFNeV/QnpzQ2Y+OtNaf34mDQgfUmi2QjZ8e6L3ag92Bw+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=z0yl9JsL; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="z0yl9JsL"
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id gAvbtmhmkXshwgB0OtREwd; Thu, 06 Feb 2025 23:09:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id gB0NthtLKUvNvgB0NtrnPY; Thu, 06 Feb 2025 23:09:55 +0000
X-Authority-Analysis: v=2.4 cv=SMZEVvvH c=1 sm=1 tr=0 ts=67a54143
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=5NrVWRCCLrfdh0Jvg2MA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E+YTnOMYFTRww4vc+3L6vgtI2NWn1P0qdxz7Mx881oE=; b=z0yl9JsLXoRh1h3AVY+uLJtw4X
	n+Hz1G6DVZbr32LccMc47/N6SN4IcKu1lFTicgeWulkvu7Iqc2w509Bgk/M6YlEZstXO5gqvfWoXP
	dIAodwRLmFy8ppN3Be5uKiRtajKK3iaHd1BKZ9g2XWiKqfNQn5hrarCjRlxKv64ynqQUBa3SxBNtv
	uWtcTIV5kARh73IG73WeIh3bCvSntiB08J9YBN9LQAkFCuw5S+qyEET7bl53wdB5q0xzpJejP8PHO
	HYDiVh6rXlRb+OLhC4HsHXCywhKlOGYZnYgNj2ZH6zvIiXgUvolo0BM4LMiV2eZAVAvDZV8Am+CzZ
	d5dL+73Q==;
Received: from [45.124.203.140] (port=54600 helo=[192.168.0.152])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tgB0M-001s8r-2D;
	Thu, 06 Feb 2025 17:09:54 -0600
Message-ID: <09e5992a-46a7-410e-a57f-3d337d282943@embeddedor.com>
Date: Fri, 7 Feb 2025 09:39:42 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ext4: avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Theodore Ts'o <tytso@mit.edu>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Zz0TEX3GycUEmISN@kspp> <20250206150910.GA1130956@mit.edu>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250206150910.GA1130956@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tgB0M-001s8r-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.152]) [45.124.203.140]:54600
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJtDE/vR1jhJoCjzgxA/itrlDMvvOYxel6VKct6YeUP6C58aLWMCi3n5xeBGUdZ9nxXd7ubwuEwq84BXmq2gQTypW18LC5B9sIKNh8dzSBfWLKN/+ebO
 WcqBj7L2eJUwXK4rOhC5Krb+hwIsLL/LPy5w9ncNOUJW+7VVEDijFTtJXFvuRYXke8D2n36LrTVjyxMlQTMQJN0iymuJIdrxlBLdF6JHylXdDFbQNB19kkbe


> Thanks, for this patch!  It appears that this patch has since been
> obviated by Eric Bigger's commit f2b4fa19647e (" ext4: switch to using
> the crc32c library"), which landed during this merge window, so this
> patch should not be needed.

Oh, nice! Thanks for letting me know. :)

-Gustavo
