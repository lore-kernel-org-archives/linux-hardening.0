Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA545ECA
	for <linux-hardening@vger.kernel.org>; Sun,  1 Oct 2023 06:51:43 +0000 (UTC)
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2D79F
	for <linux-hardening@vger.kernel.org>; Sat, 30 Sep 2023 23:51:42 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTP
	id mm6Jq1vrGQUgRmqIoqbwEf; Sun, 01 Oct 2023 06:51:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mqInqgrkjrk9tmqInqqWvm; Sun, 01 Oct 2023 06:51:41 +0000
X-Authority-Analysis: v=2.4 cv=PKccRNmC c=1 sm=1 tr=0 ts=651916fd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=E-DQCdINAI_ro2gpc_8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RQoLaawxxP4kcl3hGbY+UlKaUKWuunzhdx1htbHC0Us=; b=ARs6TH7DJ7eOprEYGqnHXt2Ac7
	SnY19R2fecsH2JZFhQq/eRTuL5MEeaQ29VfuF4f7LV2joPIePtjwFxW3f27EYaSP7IHXSuVo77tUL
	t6H7yezBDovYf7MLzhJ4YEYqvFYHDXgdQLrVz12pJI2P9bAb1lTATpC2ziMbrM8SRrj/B+wKeM4ZL
	r/RGm2b0A/vFAm1DILejcHjnfEMAdG/6vtjz7FOv6oq+UIQXflNjWk3AtZw6rw9X5GIHXA72JSkqP
	hBwfqE+HrCAFr/gBCJuKY778T3noqhwV2+zOPl56abVKBvv8mpv2Gphql3Duo4iVJLP1Nippd0Bqr
	CxdTtcvg==;
Received: from [94.239.20.48] (port=34310 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qmqIm-001UlA-0h;
	Sun, 01 Oct 2023 01:51:41 -0500
Message-ID: <933c901f-ff4f-2769-6277-b63b96903034@embeddedor.com>
Date: Sun, 1 Oct 2023 08:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 comm_runtime
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jussi Kivilinna <jussi.kivilinna@iki.fi>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZRb0WiViajjqcyKT@work> <202309291024.14F6DA0@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202309291024.14F6DA0@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmqIm-001UlA-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:34310
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 93
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB9R7DzM7oegsge71KrjfoyarlXp8ArmpqlZ0TTjm7DOnYoFJ96HABzkJrTyRtUMaoAXv6yWJeBd23LgRhrlb8cBOE5L7ZeGaVzwm/ivF2M4qzo6Ihj6
 JhGjxfgCjW+m0f9pYTOR7WPt0NcuC3J2KHLW4HYGZNJb1ftUGao0Bfb+WoPsb70+L3ywYi2kiQmeGmdgl3ZWhJpOuCNosBy7WqLZcH6Fk0U0DqCID98/N8Co
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/29/23 19:26, Kees Cook wrote:
> On Fri, Sep 29, 2023 at 05:59:22PM +0200, Gustavo A. R. Silva wrote:
>> `struct urb` is a flexible structure, which means that it contains a
>> flexible-array member at the bottom. This could potentially lead to an
>> overwrite of the objects following `receiver` in `struct comm_runtime`,
>> among them some function pointers.
>>
>> Fix this by placing the declaration of object `receiver` at the end of
>> `struct comm_runtime`.
>>
>> Fixes: ddb6b5a96437 ("ALSA: 6fire: fix DMA issues with URB transfer_buffer usage")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Should these mention -Wflex-array-member-not-at-end ?

Probably, yes. I wasn't sure about mentioning it because it's not been released yet.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
