Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7511CA1
	for <linux-hardening@vger.kernel.org>; Wed, 19 Jun 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810950; cv=none; b=PcJtwOS06q/kwbrunfOqRi2gRHkafZ+IE/6JEm3YVG0VjOH6ozz+nbaAnt39umKHo6gPJzjhQi23r55kyrvjOG8JyeG0vpyzEnq+el0JgqcVL/RqZ4Upt+tsZcS9EnD+y0RgHJqrfvAEQ61fmzcZHfdGEXBh7cCv/C/AcpKUG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810950; c=relaxed/simple;
	bh=dlVW0Zt+yD0AYF7FVIAwlp8E7GCLYrxCPZlP2ToeyWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVfyLcvnXY6ALt+NsIg7vnQkVR23NPZwCzMd1M+LvHkYaGcTZ4WFNgQpHJIjibWQPYlRbbbgYyR2BdlKtZT+AMMbIXSLYKfGHDDoAhH6mjM7kliVSPyP4yq0WGSOYcWYivShoq6KL8Iy8iz2OP/0Jg4+4s6cPrTeekNxlNH2klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XPW+p68K; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XPW+p68K"
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id Jvr2s0VUgSLKxJxDhsL6hA; Wed, 19 Jun 2024 15:27:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id JxDgsCJA469m4JxDgssrVV; Wed, 19 Jun 2024 15:27:32 +0000
X-Authority-Analysis: v=2.4 cv=QONuRBLL c=1 sm=1 tr=0 ts=6672f8e4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=UpB2q-s9SAH0Zd9J5qsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FvJxBu1YSpxd+/VCWen78+JSc56VIImOsnuc2H9+pC4=; b=XPW+p68KqNViATw/50CcjHJeqs
	iR2t1LTnsYC15yhdO/6Fs2o5FFz1iYsshhRXKp91gEHnzuzG49JRq9oNz+qAMy/B7EKh7SCV6vLs9
	v4owBH/rD+Hzilp6/lvwFZRmj+W/3PAsVpnebS2jBhbLhaWUOqmBg+YmEWJfS1qtMAs8S53K9IfKt
	OkoOkXnB5UtyR6dn5J8w2FvyDKyvJ+bmyJmC1L/cRYa29FUs1/bANOzGAeADkgz0DQmv2jJQfi0nl
	I1vueRgsGmax2jLhEBxyo8Q+0vlZed2Yu9pVplQsaE14TU7B6CUV+uhum1KYQDECKwwH+u5zh5dZp
	iDT0/O/w==;
Received: from [201.172.173.139] (port=49740 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sJxDe-000rOz-1I;
	Wed, 19 Jun 2024 10:27:30 -0500
Message-ID: <5832065e-d998-4dc7-9df9-9186d3d26d9b@embeddedor.com>
Date: Wed, 19 Jun 2024 09:27:28 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: garmin_gps: annotate struct garmin_packet
 with __counted_by
To: Nathan Chancellor <nathan@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20240619-garmin_gps_counted_by-v1-1-d8d816f085d9@gmail.com>
 <20240619144320.GA2091442@thelio-3990X>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240619144320.GA2091442@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sJxDe-000rOz-1I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:49740
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFara3vBG9hH/qxfYlryoU7127KTnZ/dyA2whPTwUYbKEnx/AfSGotgTvktx1o1VXMF84MCVYbDztLQ/xZT3tcEGkI1kuI73dQGvsjhUHkICTqP4YmGa
 oUOcWKBG9Bda8S0Atazgyu8Oe7qJT5wHyhRLGLb+g4ErieTeIMsa+dp3zLK8WEDlH17QhDGVvmpjurwD1L1biwSP8JuSMLnfRuz+q88meT+//mJIFjsM7gik



On 19/06/24 16:43, Nathan Chancellor wrote:
> On Wed, Jun 19, 2024 at 11:40:57AM +0200, Javier Carrasco wrote:
>> Use the __counted_by compiler attribute for the data[] flexible array member
>> to improve the results of array bound sanitizers.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> The size is assigned before the first reference to the flexible array
>> (see pkt_add()), which allows for a straightforward annotation without
>> further modifications.
> 
> Agreed, this seems like a reasonable patch in and of itself that should
> work:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> It might also make sense to change the pkt allocation to use
> struct_size() instead of open coding it?

+1 :)

Thanks
--
Gustavo
