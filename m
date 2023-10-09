Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7B405C5
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tiuwuZN9"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E7299
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 15:10:48 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTP
	id pv2lqzxxtNWIepySdq2cet; Mon, 09 Oct 2023 22:10:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pyScq0TwtHJPZpyScqw9Hb; Mon, 09 Oct 2023 22:10:46 +0000
X-Authority-Analysis: v=2.4 cv=Orxcdgzt c=1 sm=1 tr=0 ts=65247a66
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=TiVRK5GloQ2tXinOWEgA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z00a85cxpePpAkmDwxgedq3waCKHZ8B80JhlZHQ33mo=; b=tiuwuZN9V3RBFMGVrh2Cxj1kQq
	mdUI/UvLH2QvS96EQV2M0bdCHlELBmBS0OpPwE2WTL5nOfNv/NNd5IHux+NedAccZ6iHLfig8yjyd
	OZ6NTrJiNyHhJ7XOLHijROQEOz4zkzvyzbC6r7KH6ZQIfJs9SCBrg712wzhlcE+dTcbbuUhrdSejS
	mak7oYF0O6vhkXds87qLhAmNvfQWRKAIMzR0TGbYwV6Wa/idhnPejqqDhqkmy2CScBRZwfrS9LI28
	3puZuNXrqlm+uCj+UAVdBqIEPDLYR7ADiB83I/TZqK719k3Vfk89dafuk5Eo6APe7RmOS5QdKQf5W
	SvSS1+dA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56696 helo=[192.168.15.7])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qpySa-0029nO-1P;
	Mon, 09 Oct 2023 17:10:44 -0500
Message-ID: <f30b0784-de06-4e53-9405-69aa2f86df28@embeddedor.com>
Date: Mon, 9 Oct 2023 16:10:42 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSRvh1j2MVVhuOUv@work> <202310091503.E59363D14@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310091503.E59363D14@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qpySa-0029nO-1P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:56696
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLKGp5q+9IinkLhypPy6RxqNmfmIpGtoOarnfZSb+CvWMp2LROQv3U9OFr+45HUzk2LidmdM+HCgUdPlVIgsM0d5twCjtKQw/NxmGADuMTLF0xjTR6m6
 9DwhT5pcE+bXF4BX95b7zBYxgbQ9+I9J8rqU7CyjgTRtFsMGegUSlGymHFCeDYkk/R+I+p5ZA9sKCdcdGFSueDNrEcUtSYLHxqJYjY/HXDfCReD1Gy0qSX65
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/23 00:03, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 03:24:23PM -0600, Gustavo A. R. Silva wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> While there, use struct_size() and size_sub() helpers, instead of the
>> open-coded version, to calculate the size for the allocation of the
>> whole flexible structure, including of course, the flexible-array
>> member.
>>
>> This code was found with the help of Coccinelle, and audited and
>> fixed manually.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   sound/soc/codecs/sigmadsp.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
>> index b93c078a8040..56546e2394ab 100644
>> --- a/sound/soc/codecs/sigmadsp.c
>> +++ b/sound/soc/codecs/sigmadsp.c
>> @@ -43,7 +43,7 @@ struct sigmadsp_data {
>>   	uint32_t samplerates;
>>   	unsigned int addr;
>>   	unsigned int length;
>> -	uint8_t data[];
>> +	uint8_t data[] __counted_by(length);
>>   };
>>   
>>   struct sigma_fw_chunk {
>> @@ -270,7 +270,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
>>   
>>   	length -= sizeof(*data_chunk);
>>   
>> -	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
>> +	data = kzalloc(struct_size(data, data, length), GFP_KERNEL);
>>   	if (!data)
>>   		return -ENOMEM;
>>   
>> @@ -413,7 +413,8 @@ static int process_sigma_action(struct sigmadsp *sigmadsp,
>>   		if (len < 3)
>>   			return -EINVAL;
>>   
>> -		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
>> +		data = kzalloc(struct_size(data, data, size_sub(len, 2)),
>> +			       GFP_KERNEL);
> 
> Since len was just size-checked before the alloc, size_sub() is a bit of
> overkill, but it's not technically wrong. :P

Oops.. yep, you're right, I totally overlooked that check.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
