Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858001D1E75
	for <linux-hardening@vger.kernel.org>; Fri, 25 Oct 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892318; cv=none; b=UdNbJaR1CvYCjycFLhngAYavTFER9CMNbWsjmDLIiKuQ9Wukf/Hr6Zp0O28eZ9hopYzhw1g2NcsVKHuQThknFOPcdIpx7VVqmq/wFxtgZbKnqoblqRFf43uBYFuFN2J3dmCqZq3Z2lo7RIKCBtlRHxp4Gyp+ZyAt+JRjETuSMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892318; c=relaxed/simple;
	bh=I4L3WmLWVXVwcFAEd8nbxGNWkBX3twsIjTW6n/DSckk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFgDEMzbgEsuJZwQQDgd1JF3RuwpLHfhllvd0rWVpsKz66rAM0SeYYGjllCKwWk/QRREj4NhArTwcoIFj9y0jzie7CcNGxBKI512osZX2R9Ibv4o2DOpFZqCdzMUtY6RTr9SNBircrdiB10Fw1TLalnq9owgOgTQzGDS10Pbupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=eAAmidJC; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="eAAmidJC"
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id 420OtcdF5qvuo4S0ytngaZ; Fri, 25 Oct 2024 21:38:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4S0wtGaBbSAO34S0xtCz1k; Fri, 25 Oct 2024 21:38:35 +0000
X-Authority-Analysis: v=2.4 cv=L7obQfT8 c=1 sm=1 tr=0 ts=671c0fdb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=gBJOS_56H4mzLbNBpKUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HbH3za5CcSa8a5rGSuY3p7u9eAo4n7Ozf8hyI0JvZ98=; b=eAAmidJCijQNSJfwBmDi/J25zX
	70gP25EyzqzpWLucJX3nq/peRTYJ6oDdfeBmRZLTg9YuRQM24746J5hKTSARaTZ2fMAQxOXNhuz4A
	UAQQXj3xLDyLZERfoFPjA5wJpEcDtVnFElJakKT1LMwpeQ+RZmN4p3hJt5nAtORnO/FYNeiss/wIu
	2PBmjQhXsu5MpeDIrlQTEWeYVKtkuohNJQHKB5aO0QO5myasdHjWbQSK0txY4/g9BBAkitW7WCkMu
	TrOhuZKV09PN7K2BA7yAlfVYGONoKAOB4Aa3rEaI9hNfA6fFyj9OCWR03nFNczMbvtzPLZhYnXVHH
	3XC3Mx9A==;
Received: from [201.172.173.7] (port=51996 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t4S0w-004MvN-1J;
	Fri, 25 Oct 2024 16:38:34 -0500
Message-ID: <86e72cf7-50df-4251-83df-bf4345cf2979@embeddedor.com>
Date: Fri, 25 Oct 2024 15:38:33 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
References: <Zxv7KtPEy1kvnTPM@kspp>
 <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
 <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
 <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
 <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
 <192eb05afffd37bd13ff9bc1fc9b044b347b5dc4.camel@sipsolutions.net>
 <7e2745d9-f607-4b9b-87c6-0623708747ef@embeddedor.com>
 <49a18a9a482263e9063a0afc8b93de451dbe4d84.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <49a18a9a482263e9063a0afc8b93de451dbe4d84.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t4S0w-004MvN-1J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:51996
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDMyAz4nBoqVmvW1/3kSjZGBQgBVXjPTCJmHnDBvfXtaDRtAdW77pVohe0b6e5l4jAi2hwOuuQz6agKznTv8MvZbizMnFAdaUZwZcVzaL7cir9BY30TG
 kHwc7PcTr2Cf1nst23CN3dfGfAVNnaofwXnyb415h1gjX1/NNrDgn1RlK8nluaerKNkUlQ9LaNgFELEMPaemZMaNYVP8/VZQp6MUYXVPa/If5PjsQpSDjbQ3



On 25/10/24 15:16, Johannes Berg wrote:
> On Fri, 2024-10-25 at 15:10 -0600, Gustavo A. R. Silva wrote:
>>
>> On 25/10/24 14:48, Johannes Berg wrote:
>>> On Fri, 2024-10-25 at 14:36 -0600, Gustavo A. R. Silva wrote:
>>>>>>
>>>>>> Yeah, I was actually going to mention this commit, as it's the one that introduced
>>>>>> that `bool radar_detected` to the flex struct. However, it wasn't obvious to me
>>>>>> how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detected` as I didn't
>>>>>> see `conf->drv_priv` being accessed through `struct struct ieee80211_chanctx_conf`.
>>>>>
>>>>> You have to look at the drivers, see hwsim_clear_chanctx_magic() for
>>>>> example; I wonder why hwsim_check_chanctx_magic() never caught this.
>>>>
>>>> Sorry, I actually meant through `struct ieee80211_chanctx`. Something like:
>>>>
>>>> struct ieee80211_chanctx *foo;
>>>> ...
>>>>
>>>> foo->conf.drv_priv[i] = something;
>>>>
>>>> or
>>>>
>>>> struct bar *ptr = (void *)foo->conf->drv_priv;
>>>> then write something into *ptr...
>>>>
>>>> In the above cases the code will indeed overwrite `radar_detected`.
>>>
>>> Right, that's what it does though, no? Except it doesn't have, in the
>>> driver, "foo->conf." because mac80211 only gives it a pointer to conf,
>>> so it's only "conf->drv_priv" (and it's the "struct bar" example.)
>>
>> OK, so do you mean that pointer to `conf` is actually coming from
>> `foo->conf`?
> 
> Well depends what code you're looking at? I guess we should get more
> concrete now. Let's say hwsim:
> 
> struct hwsim_chanctx_priv {
>          u32 magic;
> };
> 
> ...
> 
> static inline void hwsim_set_chanctx_magic(struct ieee80211_chanctx_conf *c)
> {
>          struct hwsim_chanctx_priv *cp = (void *)c->drv_priv;
>          cp->magic = HWSIM_CHANCTX_MAGIC;
> }
> 
> probably shouldn't be marked 'inline' now that I look at it :-)
> 
> This is being called in hwsim itself, of course:
> 
> static int mac80211_hwsim_add_chanctx(struct ieee80211_hw *hw,
>                                        struct ieee80211_chanctx_conf *ctx)
> {
>          hwsim_set_chanctx_magic(ctx);
> ...
> 
> which is only referenced as a function pointer in the ops:
> 
> static const struct ieee80211_ops mac80211_hwsim_mchan_ops = {
> ...
> 	.add_chanctx = mac80211_hwsim_add_chanctx,
> 
> (via some macros)
> 
> 
> And that's called by mac80211:
> 
> static inline int drv_add_chanctx(struct ieee80211_local *local,
>                                    struct ieee80211_chanctx *ctx)
> {
>          int ret = -EOPNOTSUPP;
> 
>          might_sleep();
>          lockdep_assert_wiphy(local->hw.wiphy);
> 
>          trace_drv_add_chanctx(local, ctx);
>          if (local->ops->add_chanctx)
>                  ret = local->ops->add_chanctx(&local->hw, &ctx->conf);
> 
> 
> so you see that the struct ieee80211_chanctx is never passed to the
> driver, but instead &ctx->conf, which is the struct with the flex array
> for driver priv.
> 
> So in this example, struct hwsim_chanctx_priv::magic overlaps the
> radar_detected value.
> 
> 
> (The allocation happens via chanctx_data_size.)

Ah, I see now. Thanks so much for this!

It really obscures the whole thing when pointers to flex structs
are passed to functions, and then the flex-array member is finally
accessed after a few more calls.

This is precisely why -Wfamnae is needed, because it's not that
obvious for people to immediately notice when they are introducing
this kinds of bugs.

OK, I'll send v2, shortly.

Thanks!
--
Gustavo

