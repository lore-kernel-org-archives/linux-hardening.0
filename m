Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9328302157;
	Fri, 24 Oct 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320225; cv=none; b=Q00s8xv+9CMk8oDwVowYMSOZ4FgWkmsEwU7nasOcKPHl7KnkKBO+UCqS47QWXJTqpg4KVKyr3EO5tOVvPegLw1P8+sFaiW3/S0BVPJnGJ7gS/BuwoCGgMyrSLxRPo9DWcL7PAlzpGJkdeTzR8Z4Jlg6iDybwl+1/xvwG1U8aSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320225; c=relaxed/simple;
	bh=AgYdT7YB2xxwLbJHg3/succLrKYoP/PPcqdqImF3crU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P26TWJEpNGWFavr/SH2ZgVpz1/IkeSlV12EsDL+Qw7XOL36XyXrhmyBwQxkaC/scdy82Y8wfanMp6R9rFOFyBW3SfHkp7mWANd2538XDXjfdIHPEYffi58Ei4Qvazkpha3e/jdMaM+roz90fZu7MD663Y45ezzD8JPyqu9fr+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=s5KqXpOe; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="s5KqXpOe"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id CIP5vStgcKXDJCJqav7P4d; Fri, 24 Oct 2025 15:36:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id CJqYvtRhZMoIXCJqZvGY41; Fri, 24 Oct 2025 15:36:55 +0000
X-Authority-Analysis: v=2.4 cv=R7wDGcRX c=1 sm=1 tr=0 ts=68fb9d17
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4oHATN8Nx7vVUZJYxp75bA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7T7KSl7uo7wA:10
 a=ejCFXqOAJi88KBG5-skA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PYq2fPB27ReF2cDwOstKi/I5IpH5649wXvX+ugiEd8M=; b=s5KqXpOeJHb5Dr0aEkqViGiPzg
	FQ+rJy88GCviZlxTWIyxFn0xaTPsHJ6pauvVftWGuc1a6ygfq8aOAguhbOD6Ltw2FM+fEtrvpQiR4
	CHBPCrWD7LQK45LyEVpSCEKbgTzlrqBsIKYCxOWI6POPRqb9jicribi6irlSoe9ns8mEdQnxYaLlR
	3g91QUKBEdmlXiFiXImqFFyTwFUw6AvkzO8Vbg9sEfBuG6Y//zKUxbZtub8XqH+auukrkX2kc4Yuu
	fvQdw51LqtwcL20gogfx/ehMRFZ7yttL7mF097A1DI3J9Gn9ayRhKz7b3hrW2Y0lGhyDUK7B6Blip
	jvia2CzQ==;
Received: from [185.134.146.81] (port=60908 helo=[10.35.193.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vCFu8-00000000imq-29tU;
	Fri, 24 Oct 2025 06:24:20 -0500
Message-ID: <949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
Date: Fri, 24 Oct 2025 12:24:09 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aPdx4iPK4-KIhjFq@kspp> <20251023172518.3f370477@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251023172518.3f370477@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.134.146.81
X-Source-L: No
X-Exim-ID: 1vCFu8-00000000imq-29tU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.35.193.44]) [185.134.146.81]:60908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI592vB+X0lc0nkvl0to5DfCgGqLVUpbXbxw/w0lQZJwAEJ+8BVhi1Wk7bdqa7xWAfFRAHdJcwUy37JTp0NaeUx7oPGSu5cdZd9ivwHr31p3/Kk1tyoY
 VOpMYD6/ixqxhINHJmCrP6JxERopt2Qo4/1xz3zOgKFnOVAreG9nG8UCMIaFvcXyd2ryXqk/a5Ku1RWmFJ2AI3ePn2kA8PgZsBDzLax+81Q7aPmRyaU5tjRF
 8ySFyTzUADBuKZwDygg7km6DGmOWrvitNgEoyzfKHog=



On 10/24/25 01:25, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 12:43:30 +0100 Gustavo A. R. Silva wrote:
>>   struct ip_options_data {
>> -	struct ip_options_rcu	opt;
>> -	char			data[40];
>> +	TRAILING_OVERLAP(struct ip_options_rcu, opt, opt.__data,
>> +			 char			data[40];
>> +	);
>>   };
> 
> Is there a way to reserve space for flexible length array on the stack
> without resorting to any magic macros? This struct has total of 5 users.

Not that I know of. That's the reason why we had to implement macros like
TRAILING_OVERLAP(), DEFINE_FLEX(), DEFINE_RAW_FLEX().

Regarding these three macros, the simplest and least intrusive one to use is
actually TRAILING_OVERLAP(), when the flex-array member is not annotated with
the counted_by attribute (otherwise, DEFINE_FLEX() would be preferred).

Of course, the most straightforward alternative is to use fixed-size arrays
if flex arrays are not actually needed.

Thanks
-Gustavo

