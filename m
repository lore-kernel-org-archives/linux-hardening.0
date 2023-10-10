Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D2D314
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n0IIPU70"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32989B4
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 05:44:49 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTP
	id pwKzqpL5AqBU3qC6SqtoYH; Tue, 10 Oct 2023 12:44:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id qC6Rq9YyRZO2dqC6RqSMwA; Tue, 10 Oct 2023 12:44:47 +0000
X-Authority-Analysis: v=2.4 cv=fNgqYLWe c=1 sm=1 tr=0 ts=6525473f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10
 a=jDH3Shn7vTvwIdt3UFAA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w69pY1l90qXB0+Na6v5MmCnARPNAj99fld00SExm3i8=; b=n0IIPU70CeF1gla0g/bB3sif3p
	0IQJuOZxW/vc8fXodjZTtPNS/9Ocyqvt7LepwbzuysMJMSf06kNIwKaLWwhbndcC6RzBtyNpO0w4H
	efqGQ6fF192ZRjuHCgkmmwLvefCI0zm08RvXQxm6+kmz3YbzoKcbvEi5SWNIw/5t8RQFUzQ7FNai7
	Tk5cXaEhRP9Nz1rAOM5BJqWNYrX2AhJpifnTrgq8kI5JKxsru4wvGnvk1JFnL9UoMXqIF3xXmZMHD
	rrdrRehvta5S/dD43ubSvEWG7ZHAmEZUNKRWUDvtwVBQJY7nCY++ZyQslmEI+Ye9TrI04ywbO/DEt
	qC440T/w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:57606 helo=[192.168.15.7])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qqC6Q-0029an-2c;
	Tue, 10 Oct 2023 07:44:46 -0500
Message-ID: <584b8c6f-a77d-482f-a33e-c6043b080b3e@embeddedor.com>
Date: Tue, 10 Oct 2023 06:44:43 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZSRXXvWMMkm7qqRW@work> <202310091253.665A9C9@keescook>
 <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
 <202310091341.74A2D82BB@keescook> <877cnv57cx.fsf@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <877cnv57cx.fsf@kernel.org>
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
X-Exim-ID: 1qqC6Q-0029an-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:57606
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA7o8gG3b6V16HqGnWdqirYTgyHeF1ApLDhW9bz/Lc66F6LWuNUIMIE8cYpKGTFSz///uhsFDn5bAlHoa4CspJOyGHbsjRGnLIxNH7WaoIfqedV30aVb
 l6LoKYB8yN8AKfdOIpMtgb01Ki7nVIEyLYzpzzB2vTbnm5DeNszjYGGQnp/51JJAjuDXE2YJAfcX7eQWb9MJph717czz34umxE+kfXGUm/Xpf1Tk/xYlIX+8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/23 08:17, Kalle Valo wrote:

> 
> No need to resend. I marked Kees' version as Superseded so that I don't
> accidentally take the wrong version.
> 
> In the title "wifi:" is missing but I can add that during commit.
> 

Awesome. :)

Thanks, Kalle!
--
Gustavo
